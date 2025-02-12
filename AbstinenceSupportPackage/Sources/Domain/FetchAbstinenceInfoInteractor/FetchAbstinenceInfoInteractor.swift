// Created by okazakishinya on 2025/02/12.

import Foundation
import Interface
import Entity
import Dependencies
import Infrastructure

struct FetchAbstinenceInfoInteractor: FetchAbstinenceInfoUseCase {

    @Dependency(\.keyChainHelper) var keyChainHelper

    func execute() async -> AbstinenceInformation? {
        keyChainHelper.readAbstinenceInformation()
    }
}
