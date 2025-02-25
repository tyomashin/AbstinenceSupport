// Created by okazakishinya on 2025/02/13.

import Foundation
import Interface
import Entity
import Common

class TopViewModelPreview: TopViewModelProtocol {
    var abstinenceInformation: AbstinenceInformation = .init(
        title: "サンプル",
        detail: "詳細です",
        targetDays: 10,
        scheduledReportDate: Date(),
        startDate: DateUtils.add(days: -5, to: Date()) ?? Date()
    )

    var isCompletedInitialization: Bool = true
    var isEnableReportButton: Bool = true
    var restrictiveAbortState: RestrictiveAbortState = .unrestricted
    var isProcessing: Bool = false
    var alertInfo: AlertInfo?
    var isPresentedAlert: Bool = false

    func setupIfNeeded() async {}
    func tappedSuccessReportButton() {
        abstinenceInformation.progressStatus = .success
    }
    func tappedFailureReportButton() {
        abstinenceInformation.progressStatus = .penaltyUnpaidForFailure
    }
    func tappedAbortButton() {}
    func tappedNewStartButton() {}
}

extension TopViewModelProtocol where Self == TopViewModelPreview {
    static var preview: Self {
        TopViewModelPreview()
    }
}
