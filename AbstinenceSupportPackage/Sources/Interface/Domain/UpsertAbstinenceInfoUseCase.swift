// Created by okazakishinya on 2025/02/12.

import Foundation
import Entity

public protocol UpsertAbstinenceInfoUseCase: Sendable {
    func execute(_ info: AbstinenceInformation) async
}
