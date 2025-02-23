// Created by okazakishinya on 2025/02/21.

import Foundation
import WidgetKit
import Entity
import Domain
import Common

/// 禁欲の TimeLineEntry
///
/// NOTE:
///     - WidgetKit に対して更新タイミングを知らせるための date を格納
///     - Widget に描画するデータを格納
struct AbstinenceTimelineEntry: TimelineEntry {
    /// ウィジェット更新日時
    let date: Date
    /// 禁欲情報
    var entity: AbstinenceInformation?

    /// 進捗 View のタイトル
    func progressTitle(with entity: AbstinenceInformation) -> LocalizedString {
        switch entity.progressStatus {
        case .inProgress:
            .widgetProgressInProgressTitle
        case .success:
            .widgetProgressSuccessTitle
        case .penaltyUnpaidForFailure, .penaltyPaidForFailure:
            .widgetProgressFailureTitle
        }
    }

    /// 進捗 View の色
    func progressColor(with entity: AbstinenceInformation) -> ColorAssets {
        switch entity.progressStatus {
        case .inProgress, .success, .penaltyPaidForFailure:
            ColorAssets.deepAccent
        case .penaltyUnpaidForFailure:
            ColorAssets.subBland
        }
    }

    /// 次回報告予定日
    func nextReportStartDateString(with entity: AbstinenceInformation, widgetFamily: WidgetFamily) -> LocalizedString? {
        guard let nextReportStartDateString = entity.nextReportStartDateString else { return nil }
        switch entity.progressStatus {
        case .inProgress:
            switch widgetFamily {
            case .systemSmall:
                return .widgetScheduledReportDateForSmall(startDate: nextReportStartDateString)
            default:
                return .widgetScheduledReportDateForNormal(startDate: nextReportStartDateString)
            }
        case .success, .penaltyUnpaidForFailure, .penaltyPaidForFailure:
            return nil
        }
    }

    /// ウィジェットタイトル
    func title(with entity: AbstinenceInformation) -> LocalizedString? {
        switch entity.progressStatus {
        case .inProgress, .success, .penaltyUnpaidForFailure:
            .anyText(entity.title)
        case .penaltyPaidForFailure:
            nil
        }
    }

    /// ウィジェット詳細
    func detail(with entity: AbstinenceInformation) -> LocalizedString? {
        switch entity.progressStatus {
        case .inProgress, .success, .penaltyUnpaidForFailure:
            nil
        case .penaltyPaidForFailure:
            .widgetContentPaidTitle
        }
    }
}
