// Created by okazakishinya on 2025/02/12.

import Foundation
import Interface
import Entity

final class KeyChainHelperStub: KeyChainHelperProtocol, @unchecked Sendable {

    var abstinenceInformation: AbstinenceInformation?

    func save<Item: Codable>(abstinenceInformation: Item) {
        self.abstinenceInformation = abstinenceInformation as? AbstinenceInformation
    }

    func readAbstinenceInformation<Item: Codable>() -> Item? {
        abstinenceInformation as? Item
    }
}
