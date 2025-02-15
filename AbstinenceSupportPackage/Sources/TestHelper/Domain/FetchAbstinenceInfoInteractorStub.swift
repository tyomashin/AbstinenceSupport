// Created by okazakishinya on 2025/02/13.

import Foundation
import Interface
import Entity

final class FetchAbstinenceInfoInteractorStub: FetchAbstinenceInfoUseCase, @unchecked Sendable {

    var abstinenceInformation: AbstinenceInformation?

    func execute() async -> AbstinenceInformation? {
        abstinenceInformation
    }
}
