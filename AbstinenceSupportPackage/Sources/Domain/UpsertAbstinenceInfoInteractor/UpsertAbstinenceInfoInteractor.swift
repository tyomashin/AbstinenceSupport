// Created by okazakishinya on 2025/02/12.

import Foundation
import Interface
import Entity
import Dependencies
import Infrastructure

struct UpsertAbstinenceInfoInteractor: UpsertAbstinenceInfoUseCase {

    @Dependency(\.keyChainHelper) var keyChainHelper

    func execute(_ info: AbstinenceInformation) async {
        keyChainHelper.save(abstinenceInformation: info)
    }
}
