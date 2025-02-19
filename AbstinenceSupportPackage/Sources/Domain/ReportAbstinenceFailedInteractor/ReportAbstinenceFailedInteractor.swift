// Created by okazakishinya on 2025/02/19.

import Foundation
import Interface
import Dependencies
import Infrastructure
import Entity

struct ReportAbstinenceFailedInteractor: ReportAbstinenceFailedUseCase {

    @Dependency(\.keyChainHelper) var keyChainHelper
    @Dependency(\.userNotificationsHelper) var userNotificationsHelper

    func execute(with abstinenceInformation: AbstinenceInformation) async -> AbstinenceInformation {
        var currentInfo = abstinenceInformation
        currentInfo.progressStatus = .penaltyUnpaidForFailure
        keyChainHelper.save(abstinenceInformation: currentInfo)
        // スケジュール中の通知を破棄する
        await userNotificationsHelper.removeAllScheduledNotifications()
        return currentInfo
    }
}
