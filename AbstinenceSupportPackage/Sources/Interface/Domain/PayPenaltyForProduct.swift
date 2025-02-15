// Created by okazakishinya on 2025/02/16.

import Foundation
import Entity

public protocol PayPenaltyForProductUseCase: Sendable {
    /// ペナルティ（課金商品）を支払う処理を実行する
    /// - Parameter productID: プロダクトID
    /// - Returns: 処理結果
    func execute(for productID: String) async -> Result<Void, PayPenaltyForProductError>
}
