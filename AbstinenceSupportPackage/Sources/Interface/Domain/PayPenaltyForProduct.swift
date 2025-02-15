// Created by okazakishinya on 2025/02/16.

import Foundation
import Entity

public protocol PayPenaltyForProductUseCase: Sendable {
    func execute(for productID: String) async -> Result<Void, PayPenaltyForProductError>
}
