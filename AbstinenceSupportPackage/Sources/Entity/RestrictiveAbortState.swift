// Created by okazakishinya on 2025/02/19.

import Foundation

/// 中止できるかどうかの制限状態
public enum RestrictiveAbortState: Sendable, Equatable {
    /// 制限なし
    case unrestricted
    /// 制限あり. releaseDays は制限解除までの日数
    case restricted(releaseDays: Int)
}
