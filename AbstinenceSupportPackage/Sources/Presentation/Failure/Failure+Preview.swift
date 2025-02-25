// Created by okazakishinya on 2025/02/23.

import Foundation
import Interface
import Entity
import Common

class FailureViewModelFreePenaltyPreview: FailureViewModelProtocol {
    var alertInfo: AlertInfo?
    var isPresentedAlert: Bool = false
    var abstinenceInformation: AbstinenceInformation = .init(
        title: "sample", detail: nil, targetDays: 1, scheduledReportDate: Date(), startDate: Date()
    )
    var isPaying: Bool = false
    func payPenalty() {}
}

class FailureViewModelPenaltyPreview: FailureViewModelProtocol {
    var alertInfo: AlertInfo?
    var isPresentedAlert: Bool = false
    var abstinenceInformation: AbstinenceInformation = .init(
        title: "sample",
        detail: nil,
        targetDays: 1,
        scheduledReportDate: Date(),
        startDate: Date()
    )
    var isPaying: Bool = false
    func payPenalty() {}
}

extension FailureViewModelProtocol where Self == FailureViewModelFreePenaltyPreview {
    static var previewFreePenalty: Self {
        FailureViewModelFreePenaltyPreview()
    }
}

extension FailureViewModelProtocol where Self == FailureViewModelPenaltyPreview {
    static var previewPenalty: Self {
        FailureViewModelPenaltyPreview()
    }
}
