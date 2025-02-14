// Created by okazakishinya on 2025/02/12.

import Foundation

/// 禁欲の進捗
public enum AbstinenceProgressStatus: Codable, Sendable {
    /// 進行中
    case inProgress
    /// 成功
    case success
    /// 失敗（ペナルティ未払い）
    case penaltyUnpaidForFailure
    /// 失敗（ペナルティ支払い済み）
    case penaltyPaidForFailure

    var isFailure: Bool {
        switch self {
        case .inProgress, .success:
            false
        case .penaltyUnpaidForFailure, .penaltyPaidForFailure:
            true
        }
    }
}
