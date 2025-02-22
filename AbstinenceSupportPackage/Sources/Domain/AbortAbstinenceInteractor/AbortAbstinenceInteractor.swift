// Created by okazakishinya on 2025/02/14.

import Foundation
import Interface
import Dependencies
import Infrastructure
import Entity

struct AbortAbstinenceInteractor: AbortAbstinenceUseCase {

    @Dependency(\.upsertAbstinenceInfoInteractor) var upsertAbstinenceInfoInteractor
    @Dependency(\.keyChainHelper) var keyChainHelper
    @Dependency(\.userNotificationsHelper) var userNotificationsHelper

    func execute(with abstinenceInformation: AbstinenceInformation, abortedDate: Date) async -> AbstinenceInformation {
        var currentInfo = abstinenceInformation
        currentInfo.progressStatus = .penaltyPaidForFailure
        await upsertAbstinenceInfoInteractor.execute(currentInfo)
        keyChainHelper.save(abortDate: abortedDate)
        // スケジュール中の通知を破棄する
        await userNotificationsHelper.removeAllScheduledNotifications()
        return currentInfo
    }
}
