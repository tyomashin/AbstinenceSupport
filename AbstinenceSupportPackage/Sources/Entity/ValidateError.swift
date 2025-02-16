// Created by okazakishinya on 2025/02/16.

import Foundation
import Common

/// バリデーションエラー
public enum ValidationError: Sendable {
    /// 未入力
    case empty

    public var error: String {
        switch self {
        case .empty:
            LocalizedString.validationErrorEmpty.localizedString
        }
    }
}
