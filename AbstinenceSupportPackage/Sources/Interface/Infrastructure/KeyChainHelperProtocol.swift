// Created by okazakishinya on 2025/02/11.

import Foundation

public protocol KeyChainHelperProtocol: Sendable {
    func save<Item: Codable>(abstinenceInformation: Item)
    func readAbstinenceInformation<Item: Codable>() -> Item?
}
