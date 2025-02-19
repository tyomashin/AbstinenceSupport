// Created by okazakishinya on 2025/02/19.

import Foundation
import Interface
import Dependencies
import Infrastructure
import Entity

struct ReportAbstinenceFailedInteractor: ReportAbstinenceFailedUseCase {

    @Dependency(\.keyChainHelper) var keyChainHelper

    func execute(with abstinenceInformation: AbstinenceInformation) async -> AbstinenceInformation {
        var currentInfo = abstinenceInformation
        currentInfo.progressStatus = .penaltyUnpaidForFailure
        keyChainHelper.save(abstinenceInformation: currentInfo)
        return currentInfo
    }
}
