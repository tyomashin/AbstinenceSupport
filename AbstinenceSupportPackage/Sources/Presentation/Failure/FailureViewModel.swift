// Created by okazakishinya on 2025/02/22.

import Foundation
import Dependencies
import Interface
import Entity
import Domain
import Common

class FailureViewModel: FailureViewModelProtocol {
    @Published var abstinenceInformation: AbstinenceInformation
    @Published var isPaying = false
    @Published var isPresentedAlert = false
    public var alertInfo: AlertInfo? {
        didSet {
            self.isPresentedAlert = alertInfo != nil
        }
    }

    @Dependency(\.upsertAbstinenceInfoInteractor) var upsertAbstinenceInfoInteractor
    @Dependency(\.notifyChangedAppTransitionState) var notifyChangedAppTransitionState
    @Dependency(\.rewardedAdManager) var rewardedAdManager

    init(abstinenceInformation: AbstinenceInformation) {
        self.abstinenceInformation = abstinenceInformation
    }

    func tappedShowAD() {
        guard !isPaying else { return }
        isPaying = true
        Task {
            guard await rewardedAdManager.loadAd() else {
                isPaying = false
                showFailedADAlert()
                return
            }
            await rewardedAdManager.showAd { [weak self] rewardAmonut in
                guard let self else { return }
                self.completedShowAD(with: rewardAmonut)
                isPaying = false
            }
        }
    }
}

extension FailureViewModel {
    /// 広告読み込み失敗時のアラートを表示
    fileprivate func showFailedADAlert() {
        alertInfo = .init(
            title: LocalizedString.failureShowADFailedAlertTitle.localizedString,
            message: LocalizedString.failureShowADFailedAlertDetail.localizedString,
            buttonList: [
                .init(
                    title: LocalizedString.okButton.localizedString,
                    role: .none,
                    action: nil
                )
            ]
        )
    }

    /// 広告表示完了時の処理
    fileprivate func completedShowAD(with rewardAmonut: Int?) {
        Task {
            guard let rewardAmonut, rewardAmonut > 0 else {
                showFailedADAlert()
                return
            }
            abstinenceInformation.progressStatus = .penaltyPaidForFailure
            await upsertAbstinenceInfoInteractor.execute(abstinenceInformation)
            // 画面遷移要求
            notifyChangedAppTransitionState(nil)
        }
    }
}
