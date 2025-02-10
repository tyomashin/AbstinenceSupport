// Created by okazakishinya on 2025/02/09.

import Foundation
import SwiftUI

/// アセットカタログから色を取得する
///
/// - Note:
///     Xcode によって Asset Symbol は自動生成されるがアクセスレベルが public ではないため他モジュールからは直接参照できない
///     https://developer.apple.com/forums/thread/756954
public enum ColorAssets {
    case baseBland
    case subBland
    case deepBland
    case baseAccent
    case subAccent
    case deepAccent
    case baseBackground
    case subBackground
    case baseText
    case subText
    case baseWhite
    case placeholder
    case shadow
    case baseDisabled
    case baseAlert
}

extension ColorAssets {
    public var color: Color {
        switch self {
        case .baseBland:
            Color.baseBland
        case .subBland:
            Color.subBland
        case .deepBland:
            Color.deepBland
        case .baseAccent:
            Color.baseAccent
        case .subAccent:
            Color.subAccent
        case .deepAccent:
            Color.deepAccent
        case .baseBackground:
            Color.baseBackground
        case .subBackground:
            Color.subBackground
        case .baseText:
            Color.baseText
        case .subText:
            Color.subText
        case .baseWhite:
            Color.baseWhite
        case .placeholder:
            Color.placeholder
        case .shadow:
            Color.shadow
        case .baseDisabled:
            Color.baseDisabled
        case .baseAlert:
            Color.baseAlert
        }
    }
}
