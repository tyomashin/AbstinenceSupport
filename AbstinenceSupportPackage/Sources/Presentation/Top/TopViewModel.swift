// Created by okazakishinya on 2025/02/19.

import Foundation
import SwiftUI
import Dependencies
import Interface
import Entity
import Domain
import Common
import Infrastructure

public final class TopViewModel: TopViewModelProtocol {

    @Published public var abstinenceInformation: AbstinenceInformation
    @Published public var isCompletedInitialization = false
    @Published public var isPresentedAlert = false
    @Published public var isProcessing: Bool = false
    public var alertInfo: AlertInfo? {
        didSet {
            self.isPresentedAlert = alertInfo != nil
        }
    }
    public var isEnableReportButton: Bool {
        guard abstinenceInformation.progressStatus == .inProgress else { return false }
        let currentDate = Date()
        guard abstinenceInformation.nextReportStartDate <= currentDate else { return false }
        guard currentDate <= abstinenceInformation.nextReportEndDate else { return false }
        return true
    }
    public var restrictiveAbortState: RestrictiveAbortState = .unrestricted
    private var isExecutedSetup = false

    @Dependency(\.setupAbstinenceInteractor) var setupAbstinenceInteractor
    @Dependency(\.minuteTaskClock) var minuteTaskClock
    @Dependency(\.userNotificationsHelper) var userNotificationsHelper
    @Dependency(\.reportAbstinenceAchievedInteractor) var reportAbstinenceAchievedInteractor
    @Dependency(\.reportAbstinenceFailedInteractorKey) var reportAbstinenceFailedInteractorKey
    @Dependency(\.abortAbstinenceInteractor) var abortAbstinenceInteractor
    @Dependency(\.fetchRestrictiveAbortStateInteractor) var fetchRestrictiveAbortStateInteractor
    @Dependency(\.notifyChangedAppTransitionState) var notifyChangedAppTransitionState
    @Dependency(\.upsertAbstinenceInfoInteractor) var upsertAbstinenceInfoInteractor
    @Dependency(\.registerAbstinenceNotificationInteractor) var registerAbstinenceNotificationInteractor

    init(
        abstinenceInformation: AbstinenceInformation
    ) {
        self.abstinenceInformation = abstinenceInformation
    }

    deinit {
        Task {
            @Dependency(\.minuteTaskClock) var minuteTaskClock
            await minuteTaskClock.unregister()
        }
    }

    public func setupIfNeeded() async {
        // 最初に一度だけ実行するように制御
        guard !isExecutedSetup else { return }
        isExecutedSetup = true

        // 必要な権限が未設定の場合は要求する
        await setupAbstinenceInteractor.execute()

        // 禁欲ステータスを最新化する
        let currentDate = Date()
        abstinenceInformation.updateProgressStatus(currentDate: currentDate)
        await upsertAbstinenceInfoInteractor.execute(abstinenceInformation)

        switch abstinenceInformation.progressStatus {
        case .inProgress:
            // 中止ボタンの活性・非活性化処理
            restrictiveAbortState = await fetchRestrictiveAbortStateInteractor.execute(with: currentDate)
            // 1分ごとに禁欲ステータス等の画面情報を最新化する
            await minuteTaskClock.register(checkCurrentStatus)
            isCompletedInitialization = true
        case .success:
            detectedSuccessAbstinence()
            isCompletedInitialization = true
        case .penaltyUnpaidForFailure:
            detectedFailureAbstinence()
        case .penaltyPaidForFailure:
            detectedFailureAbstinenceAlreadyPaid()
        }
    }

    public func tappedSuccessReportButton() {
        guard !isProcessing else { return }
        isProcessing = true
        Task {
            // 達成報告を行う
            abstinenceInformation = await reportAbstinenceAchievedInteractor.execute(with: abstinenceInformation, reportDate: Date())
            if abstinenceInformation.progressStatus.isSuccess {
                detectedSuccessAbstinence()
            } else {
                // 通知を再スケジュール
                await registerAbstinenceNotificationInteractor.execute()
            }
            isProcessing = false
        }
    }

    public func tappedFailureReportButton() {
        // 禁欲失敗報告の前に確認アラートを表示
        self.alertInfo = .init(
            title: LocalizedString.topReportFailAlertTitle.localizedString,
            message: LocalizedString.topReportFailAlertDetail.localizedString,
            buttonList: [
                .init(title: LocalizedString.cancelButton.localizedString, role: .cancel, action: nil),
                .init(
                    title: LocalizedString.topReportFailAlertOKButton.localizedString, role: .destructive,
                    action: { [weak self] in
                        // 確認が取れたら禁欲失敗処理を行う
                        self?.reportAbstinenceFailed()
                    }
                ),
            ]
        )
    }

    public func tappedAbortButton() {
        // 禁欲中止の前に確認アラートを表示
        self.alertInfo = .init(
            title: LocalizedString.topAbortAlertTitle.localizedString,
            message: LocalizedString.topAbortAlertDetail.localizedString,
            buttonList: [
                .init(title: LocalizedString.cancelButton.localizedString, role: .cancel, action: nil),
                .init(
                    title: LocalizedString.topAbortButtonTitle.localizedString, role: .destructive,
                    action: { [weak self] in
                        // 確認が取れたら禁欲中止処理を行う
                        self?.abortAbstinence()
                    }
                ),
            ]
        )
    }

    public func tappedNewStartButton() {
        // ルート画面に最新の禁欲状態に基づいた画面遷移を要求する
        notifyChangedAppTransitionState()
    }

}

extension TopViewModel {

    /// 禁欲ステータスを最新化する
    ///
    /// - NOTE: このメソッドは毎分呼び出される
    fileprivate func checkCurrentStatus() async {
        let currentDate = Date()
        abstinenceInformation.updateProgressStatus(currentDate: currentDate)
        await upsertAbstinenceInfoInteractor.execute(abstinenceInformation)

        switch abstinenceInformation.progressStatus {
        case .inProgress:
            // 中止ボタンの活性・非活性化処理
            restrictiveAbortState = await fetchRestrictiveAbortStateInteractor.execute(with: currentDate)
        // 禁欲ステータスが進行中以外の場合、毎分の監視処理は終了する
        case .success:
            resetSubscription()
        case .penaltyUnpaidForFailure:
            detectedFailureAbstinence()
        case .penaltyPaidForFailure:
            detectedFailureAbstinenceAlreadyPaid()
        }
    }

    /// 禁欲失敗を検知した際の処理
    fileprivate func detectedFailureAbstinence() {
        resetSubscription()
        notifyChangedAppTransitionState()
    }

    /// 禁欲失敗後にペナルティ支払い済みの場合の処理
    fileprivate func detectedFailureAbstinenceAlreadyPaid() {
        resetSubscription()
        notifyChangedAppTransitionState()
    }

    /// 禁欲成功を検知した際の処理
    fileprivate func detectedSuccessAbstinence() {
        resetSubscription()
    }

    /// 禁欲の中止処理
    fileprivate func abortAbstinence() {
        guard !isProcessing else { return }
        isProcessing = true
        Task {
            // 禁欲中止処理を実施
            abstinenceInformation = await abortAbstinenceInteractor.execute(with: abstinenceInformation, abortedDate: Date())
            resetSubscription()
            // 遷移処理
            notifyChangedAppTransitionState()
            isProcessing = false
        }
    }

    /// 禁欲の失敗報告処理
    fileprivate func reportAbstinenceFailed() {
        guard !isProcessing else { return }
        isProcessing = true
        Task {
            // 失敗報告処理
            abstinenceInformation = await reportAbstinenceFailedInteractorKey.execute(with: abstinenceInformation)
            detectedFailureAbstinence()
            isProcessing = false
        }
    }

    /// 禁欲終了後の後処理：タイマー購読解除・スケジュールした通知を削除
    fileprivate func resetSubscription() {
        Task {
            await minuteTaskClock.unregister()
            await userNotificationsHelper.removeAllScheduledNotifications()
        }
    }
}
