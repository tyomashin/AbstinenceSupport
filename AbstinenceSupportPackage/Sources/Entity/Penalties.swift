// Created by okazakishinya on 2025/02/12.

import Foundation
import Common

/// ペナルティ種別
public enum Penalties: Codable, Sendable, Equatable {
    /// 無料ペナルティ
    case free
    /// 有料ペナルティ
    case product(productID: String)
}

/// ペナルティ情報
public struct PenaltyInfo: Sendable, Equatable {
    public let title: String
    public let detail: String
    public let penaltyCategory: Penalties

    public init(title: String, detail: String, penaltyCategory: Penalties) {
        self.title = title
        self.detail = detail
        self.penaltyCategory = penaltyCategory
    }

    public static func freePenaltyInfo() -> Self {
        .init(
            title: LocalizedString.penaltyFreeTitle.localizedString,
            detail: LocalizedString.penaltyFreeDetail.localizedString,
            penaltyCategory: .free
        )
    }
}
