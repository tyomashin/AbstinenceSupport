// Created by okazakishinya on 2025/02/15.

import Foundation

/// 課金アイテムID定義
public enum PurchaseProductIDs: String, CaseIterable {

    case level1 = "penalty_level1"
    case level2 = "penalty_level2"
    case level3 = "penalty_level3"
    case level4 = "penalty_level4"
    case level5 = "penalty_level5"

    public static var enableIDs: [String] {
        Self.allCases.map(\.rawValue)
    }
}
