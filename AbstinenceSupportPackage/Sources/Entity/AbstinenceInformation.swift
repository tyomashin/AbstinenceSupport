// Created by okazakishinya on 2025/02/12.

import Foundation

/// 禁欲情報
public struct AbstinenceInformation: Codable, Sendable {
    /// やめること
    public var title: String
    /// 詳細
    public var detail: String?
    /// 禁欲目標日数
    public var targetDays: Int
    public var normalizedTargetDays: Int {
        if days < 0 { 0 }
        else { days }
    }
    /// 報告予定時刻
    public var scheduledReportDate: Date
    /// ペナルティ
    public var penalties: Penalties
    /// 禁欲の進捗
    public var progress: AbstinenceProgress
    /// 禁欲開始日時
    public let startDate: Date
}
