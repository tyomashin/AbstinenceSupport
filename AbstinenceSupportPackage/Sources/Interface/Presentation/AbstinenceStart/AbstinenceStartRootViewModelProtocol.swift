// Created by okazakishinya on 2025/02/16.

import Foundation
import Entity

@MainActor
public protocol AbstinenceStartRootViewModelProtocol: ObservableObject {

    var navigationPath: [AbstinenceStartNavigationPath] { get set }
    var abstinenceTitle: String { get }
    var detail: String? { get }
    var targetDays: Int { get }
    var reportTime: Date { get }
    var penaltyInfo: PenaltyInfo { get }

    func tappedNameEntryNextButton(title: String, detail: String?)
    func tappedTargetDaysNextButton(targetDays: Int)
    func tappedReportTimeNextButton(reportTime: Date)
    func tappedPenaltyNextButton(penaltyInfo: PenaltyInfo)
    func tappedConfirmationStartButton()
    func fetchAllPenalties() async -> [PenaltyInfo]
}
