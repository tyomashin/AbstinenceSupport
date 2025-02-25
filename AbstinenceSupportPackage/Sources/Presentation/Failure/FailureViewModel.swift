// Created by okazakishinya on 2025/02/22.

import Foundation
import Dependencies
import Interface
import Entity
import Domain
import Common

class FailureViewModel: FailureViewModelProtocol {
    @Published var abstinenceInformation: AbstinenceInformation
    @Published var isPaying = false

    @Dependency(\.upsertAbstinenceInfoInteractor) var upsertAbstinenceInfoInteractor
    @Dependency(\.notifyChangedAppTransitionState) var notifyChangedAppTransitionState

    init(abstinenceInformation: AbstinenceInformation) {
        self.abstinenceInformation = abstinenceInformation
        self.isPaying = isPaying
    }

    func payPenalty() {
        guard !isPaying else { return }
        isPaying = true
        Task {
            abstinenceInformation.progressStatus = .penaltyPaidForFailure
            await upsertAbstinenceInfoInteractor.execute(abstinenceInformation)
            // 画面遷移要求
            notifyChangedAppTransitionState()
        }
    }
}
