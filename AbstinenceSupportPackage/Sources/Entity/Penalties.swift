// Created by okazakishinya on 2025/02/12.

import Foundation

/// ペナルティ種別
public enum Penalties: Codable, Sendable, Equatable {
    /// 無料ペナルティ
    case free
    /// 有料ペナルティ
    case product(productID: String)
}
