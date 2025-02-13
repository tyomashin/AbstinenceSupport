// Created by okazakishinya on 2025/02/12.

import Foundation
import Common

/// 禁欲情報
public struct AbstinenceInformation: Codable, Sendable, Equatable {
    /// 禁欲タイトル
    public var title: String
    /// 詳細
    public var detail: String?
    /// 禁欲目標日数
    public var targetDays: Int
    public var normalizedTargetDays: Int {
        if targetDays < 0 { 0 } else { targetDays }
    }
    /// 報告予定時刻
    public var scheduledReportDate: Date
    /// ペナルティ
    public var penalties: Penalties
    /// 禁欲の進捗
    public var progressStatus: AbstinenceProgressStatus
    /// 禁欲開始日時
    public let startDate: Date
    /// 前回の禁欲報告日時
    public var currentReportedDate: Date?
    /// 報告回数
    public var reportedCount: Int = 0
    public var normalizedReportedCount: Int {
        if reportedCount < 0 { 0 } else { reportedCount }
    }
    /// 進捗率(0.0〜1.0)
    public var rateOfProgress: Float {
        guard normalizedTargetDays > 0 else { return 1 }
        return min(Float(normalizedReportedCount) / Float(normalizedTargetDays), 1)
    }
    /// 開始日時からの経過日数
    public var elapsedDays: Int {
        max(0, DateUtils.daysBetween(from: startDate, to: Date()))
    }
}
