// Created by okazakishinya on 2025/02/12.

import Foundation
import Common

/// 禁欲情報
public struct AbstinenceInformation: Codable, Sendable, Equatable, Hashable {
    /// 禁欲タイトル
    public var title: String
    /// 詳細
    public var detail: String?
    /// 禁欲目標日数
    public var targetDays: Int
    public var normalizedTargetDays: Int {
        if targetDays < 0 { 0 } else { targetDays }
    }
    /// 日々の報告予定時刻
    public var scheduledReportDate: Date
    /// 次回の報告開始日時
    public var nextReportStartDate: Date {
        // 次回の報告日を決定する
        guard var tmpNextReportStartDate = DateUtils.add(days: reportedCount + 1, to: startDate) else { return startDate }
        // 予定時刻になるように調整
        tmpNextReportStartDate = DateUtils.apply(time: DateUtils.time(from: scheduledReportDate), to: tmpNextReportStartDate)
        // 初回のみ、もし禁欲開始日時と次回報告日時が30時間以上空いている場合は当日になるように調整
        if reportedCount == 0 && DateUtils.hoursBetween(from: startDate, to: tmpNextReportStartDate) >= 30 {
            tmpNextReportStartDate = DateUtils.add(days: -1, to: tmpNextReportStartDate) ?? tmpNextReportStartDate
        }
        return tmpNextReportStartDate
    }
    /// 次回の報告終了時刻
    public var nextReportEndDate: Date {
        DateUtils.add(hours: 1, to: nextReportStartDate) ?? nextReportStartDate
    }
    /// ペナルティ
    public var penaltyInfo: PenaltyInfo
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

    public init(
        title: String,
        detail: String? = nil,
        targetDays: Int,
        scheduledReportDate: Date,
        penaltyInfo: PenaltyInfo,
        startDate: Date
    ) {
        self.title = title
        if let detail, !detail.isEmpty {
            self.detail = detail
        }
        self.targetDays = targetDays
        self.scheduledReportDate = scheduledReportDate
        self.penaltyInfo = penaltyInfo
        self.startDate = startDate
        self.progressStatus = .inProgress
        self.updateProgressStatus(currentDate: startDate)
    }

    /// 禁欲ステータスを更新する
    /// - Parameter currentDate: 現在日時
    public mutating func updateProgressStatus(currentDate: Date) {
        // すでに禁欲成功 or 失敗ステータスの場合は何もしない
        guard !progressStatus.isFailure else { return }
        guard !progressStatus.isSuccess else { return }

        // 報告回数が禁欲目標日数以上なら、禁欲成功ステータスにする
        if reportedCount >= targetDays {
            progressStatus = .success
        }
        // 現在日時が次回報告終了時刻を過ぎてしまっている場合は失敗にする
        else if currentDate > nextReportEndDate {
            progressStatus = .penaltyUnpaidForFailure
        }
        // いずれにも当てはまらない場合は進行中とする
        else {
            progressStatus = .inProgress
        }
    }
}
