// Created by okazakishinya on 2025/02/16.

import Foundation
import Interface
import Entity

class AbstinenceStartRootViewModelPreview: AbstinenceStartRootViewModelProtocol {
    var abstinenceTitle: String = "sample"
    var detail: String?
    var navigationPath: [AbstinenceStartNavigationPath] = []
    var targetDays: Int = 10
    var reportTime: Date = Date()
    var penaltyInfo: PenaltyInfo = .freePenaltyInfo()
    var isProcessing = false
    var completionHandler: (AbstinenceInformation) -> Void = { _ in }

    func tappedNameEntryNextButton(title: String, detail: String?) {}
    func tappedTargetDaysNextButton(targetDays: Int) {}
    func tappedReportTimeNextButton(reportTime: Date) {}
    func tappedPenaltyNextButton(penaltyInfo: PenaltyInfo) {}
    func tappedConfirmationStartButton() {}
    func fetchAllPenalties() async -> [PenaltyInfo] { [.freePenaltyInfo()] }
}

extension AbstinenceStartRootViewModelProtocol where Self == AbstinenceStartRootViewModelPreview {
    static var preview: Self {
        AbstinenceStartRootViewModelPreview()
    }
}

class AbstinenceStartCompletionViewModelPreview: AbstinenceStartCompletionViewModelProtocol {
    func tappedCloseButton() {}
}

extension AbstinenceStartCompletionViewModelProtocol where Self == AbstinenceStartCompletionViewModelPreview {
    static var preview: Self {
        AbstinenceStartCompletionViewModelPreview()
    }
}
