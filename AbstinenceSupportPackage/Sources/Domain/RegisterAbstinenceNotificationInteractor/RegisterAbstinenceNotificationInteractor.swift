// Created by okazakishinya on 2025/02/23.

import Foundation
import Interface
import Dependencies
import Infrastructure
import Common
import Entity

struct RegisterAbstinenceNotificationInteractor: RegisterAbstinenceNotificationUseCase {

    @Dependency(\.fetchAbstinenceInfoInteractor) var fetchAbstinenceInfoInteractor
    @Dependency(\.userNotificationsHelper) var userNotificationsHelper

    func execute() async {
        await userNotificationsHelper.removeAllScheduledNotifications()
        // アプリ内に保存されている禁欲情報を取得
        guard let info = await fetchAbstinenceInfoInteractor.execute() else { return }
        // 禁欲ステータスが進行中の場合のみ通知を設定する
        switch info.progressStatus {
        case .inProgress:
            guard let nextReportStartDateString = info.nextReportStartDateString else { return }
            guard let nextReportEndDateString = info.nextReportEndDateString else { return }
            // 禁欲開始・終了日時に通知をスケジュールする
            await userNotificationsHelper.scheduleNotification(
                id: AbstinenceNotifications.nextReportStartDate.notificationID,
                title: LocalizedString.notificationStartDateTitle.localizedString,
                body: LocalizedString.notificationStartDateDetail(startDate: nextReportStartDateString).localizedString,
                date: info.nextReportStartDate
            )
            await userNotificationsHelper.scheduleNotification(
                id: AbstinenceNotifications.nextReportEndDate.notificationID,
                title: LocalizedString.notificationEndDateTitle.localizedString,
                body: LocalizedString.notificationEndDateDetail(endDate: nextReportEndDateString).localizedString,
                date: info.nextReportEndDate
            )

        case .success, .penaltyUnpaidForFailure, .penaltyPaidForFailure:
            return
        }
    }
}
