// Created by okazakishinya on 2025/02/15.

import Foundation
import Interface
import Entity

final class UpsertAbstinenceInfoInteractorStub: UpsertAbstinenceInfoUseCase, @unchecked Sendable {

    var onCalled: ((_ info: AbstinenceInformation) -> Void)?

    func execute(_ info: AbstinenceInformation) async {
        onCalled?(info)
    }
}
