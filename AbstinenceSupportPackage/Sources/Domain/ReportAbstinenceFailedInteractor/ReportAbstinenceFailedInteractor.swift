// Created by okazakishinya on 2025/02/19.

import Foundation
import Interface
import Dependencies
import Infrastructure
import Entity

struct ReportAbstinenceFailedInteractor: ReportAbstinenceFailedUseCase {

    @Dependency(\.upsertAbstinenceInfoInteractor) var upsertAbstinenceInfoInteractor
    @Dependency(\.userNotificationsHelper) var userNotificationsHelper

    func execute(with abstinenceInformation: AbstinenceInformation) async -> AbstinenceInformation {
        var currentInfo = abstinenceInformation
        currentInfo.progressStatus = .penaltyUnpaidForFailure
        await upsertAbstinenceInfoInteractor.execute(currentInfo)
        // スケジュール中の通知を破棄する
        await userNotificationsHelper.removeAllScheduledNotifications()
        return currentInfo
    }
}
