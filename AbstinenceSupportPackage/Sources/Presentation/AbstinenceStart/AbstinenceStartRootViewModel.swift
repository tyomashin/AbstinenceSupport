// Created by okazakishinya on 2025/02/16.

import Foundation
import Dependencies
import Interface
import Entity
import Domain

class AbstinenceStartRootViewModel: AbstinenceStartRootViewModelProtocol {
    @Published var navigationPath: [AbstinenceStartNavigationPath] = []

    /// やめること
    private var abstinenceTitle: String = ""
    /// やめることの詳細（任意）
    private var detail: String?
    /// 禁欲日数
    var targetDays: Int = 10
    /// 報告時間
    var reportTime: Date = Date()
    /// ペナルティ
    var penaltyInfo: PenaltyInfo = .freePenaltyInfo()

    @Dependency(\.fetchAllPenaltyInfoInteractor) var fetchAllPenaltyInfoInteractor

    func tappedNameEntryNextButton(title: String, detail: String?) {
        self.abstinenceTitle = title
        self.detail = detail
        navigationPath.append(.targetDaysEntry)
    }

    func tappedTargetDaysNextButton(targetDays: Int) {
        self.targetDays = targetDays
        navigationPath.append(.scheduledReportDateEntry)
    }

    func tappedReportTimeNextButton(reportTime: Date) {
        self.reportTime = reportTime
        navigationPath.append(.penaltiessSlection)
    }

    func tappedPenaltyNextButton(penaltyInfo: PenaltyInfo) {
        self.penaltyInfo = penaltyInfo
        navigationPath.append(.confirmation)
    }

    func fetchAllPenalties() async -> [PenaltyInfo] {
        await fetchAllPenaltyInfoInteractor.execute()
    }

}
