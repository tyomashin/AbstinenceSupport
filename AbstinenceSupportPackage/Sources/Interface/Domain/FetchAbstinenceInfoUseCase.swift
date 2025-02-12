// Created by okazakishinya on 2025/02/12.

import Foundation
import Entity

public protocol FetchAbstinenceInfoUseCase: Sendable {
    func execute() async -> AbstinenceInformation?
}
