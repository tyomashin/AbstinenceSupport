// Created by okazakishinya on 2025/02/14.

import Foundation
import Interface
import Dependencies
import Infrastructure
import Entity

struct ReportAbstinenceAchievedInteractor: ReportAbstinenceAchievedUseCase {

    @Dependency(\.keyChainHelper) var keyChainHelper

    func execute(with abstinenceInformation: AbstinenceInformation, reportDate: Date) async -> AbstinenceInformation {
        var currentInfo = abstinenceInformation
        currentInfo.currentReportedDate = reportDate
        currentInfo.reportedCount += 1

        // 進捗状況を最新化する処理を実行
        currentInfo.updateProgressStatus(currentDate: Date())

        keyChainHelper.save(abstinenceInformation: currentInfo)
        return currentInfo
    }
}
