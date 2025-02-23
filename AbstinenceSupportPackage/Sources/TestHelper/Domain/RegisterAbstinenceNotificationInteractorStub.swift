// Created by okazakishinya on 2025/02/23.

import Foundation
import Interface
import Entity

final class RegisterAbstinenceNotificationInteractorStub: RegisterAbstinenceNotificationUseCase, @unchecked Sendable {

    var onCalled: (() -> Void)?

    func execute() async {
        onCalled?()
    }
}
