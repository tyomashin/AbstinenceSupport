// Created by okazakishinya on 2025/02/15.

import Foundation
import Interface
import Entity

final class CheckAppTransitionStateInteractorStub: CheckAppTransitionStateUseCase, @unchecked Sendable {

    var state = AppTransitionState.onboarding

    func execute() async -> AppTransitionState {
        state
    }
}
