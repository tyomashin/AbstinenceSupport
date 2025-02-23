// Created by okazakishinya on 2025/02/21.

import Foundation
import SwiftUI
import WidgetKit
import Common
import Entity
import Presentation

/// Widget に表示する View
struct AbstinenceWidgetView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: AbstinenceTimelineProvider.Entry

    init(entry: AbstinenceTimelineProvider.Entry) {
        self.entry = entry
        self.entry.entity?.updateProgressStatus(currentDate: Date())
    }

    var body: some View {
        if let entity = entry.entity {
            switch widgetFamily {
            case .systemSmall:
                contentViewSmall(with: entity)
            case .systemMedium, .systemLarge, .systemExtraLarge:
                contentViewNormal(with: entity)
            default:
                Color.clear
            }

        } else {
            emptyView
        }
    }

    /// 禁欲情報がない場合の表示
    var emptyView: some View {
        VStack(alignment: .center, spacing: 4) {
            BodyLabel(.widgetEmptyTitle, colorAssets: .baseText, weight: .bold, alignment: .center)
        }
    }

    /// WidgetFamily が systemSmall の場合の表示
    func contentViewSmall(with entity: AbstinenceInformation) -> some View {
        VStack(alignment: .center, spacing: 8) {

            // MARK: 進捗エリア

            ZStack(alignment: .center) {
                Circle()
                    .fill(ColorAssets.subBackground.color)

                Circle()
                    .inset(by: 2.5)
                    .trim(from: 0, to: CGFloat(entity.rateOfProgress))
                    .stroke(style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .foregroundStyle(entry.progressColor(with: entity).color)
                    .rotationEffect(.degrees(270))

                VStack(alignment: .center, spacing: 4) {
                    BodyLabel(
                        entry.progressTitle(with: entity),
                        colorAssets: entry.progressColor(with: entity),
                        weight: .bold,
                        alignment: .center
                    )
                    BodyLabel(
                        .topAbstinenceInprogressDays(days: entity.normalizedReportedCount),
                        colorAssets: .baseText,
                        weight: .bold,
                        alignment: .center
                    )
                }
            }

            // MARK: 次回報告予定日

            if let nextReportStartDateString = entry.nextReportStartDateString(with: entity, widgetFamily: widgetFamily) {
                CaptionLabel(nextReportStartDateString, colorAssets: .baseText, alignment: .center)
            }
        }
    }

    func contentViewNormal(with entity: AbstinenceInformation) -> some View {
        HStack(alignment: .center, spacing: 8) {

            // MARK: 進捗エリア

            ZStack(alignment: .center) {
                Circle()
                    .fill(ColorAssets.subBackground.color)

                Circle()
                    .inset(by: 4)
                    .trim(from: 0, to: CGFloat(entity.rateOfProgress))
                    .stroke(style: .init(lineWidth: 8, lineCap: .round, lineJoin: .round))
                    .foregroundStyle(entry.progressColor(with: entity).color)
                    .rotationEffect(.degrees(270))

                VStack(alignment: .center, spacing: 4) {
                    BodyLabel(
                        entry.progressTitle(with: entity),
                        colorAssets: entry.progressColor(with: entity),
                        weight: .bold,
                        alignment: .center
                    )
                    BodyLabel(
                        .topAbstinenceInprogressDays(days: entity.normalizedReportedCount),
                        colorAssets: .baseText,
                        weight: .bold,
                        alignment: .center
                    )
                }
            }
            .padding(.horizontal, 10)

            VStack(alignment: .leading, spacing: 8) {

                // MARK: 禁欲情報

                if let title = entry.title(with: entity) {
                    BodyLabel(title, colorAssets: .baseBland, weight: .bold, alignment: .leading)
                }

                if let detail = entry.detail(with: entity) {
                    BodyLabel(detail, colorAssets: .baseText, weight: .regular, alignment: .leading)
                }

                // MARK: 次回報告予定日

                if let nextReportStartDateString = entry.nextReportStartDateString(with: entity, widgetFamily: widgetFamily) {
                    FootnoteLabel(nextReportStartDateString, colorAssets: .baseText, weight: .bold, alignment: .leading)
                }
            }
        }
    }
}

// MARK: - Previews

// MARK: systemSmall

#Preview("systemSmall inprogress", as: .systemSmall) {
    AbstinenceWidget()
} timeline: {
    AbstinenceTimelineEntry(date: Date(), entity: .previewWithInProgress)
}

#Preview("systemSmall success", as: .systemSmall) {
    AbstinenceWidget()
} timeline: {
    AbstinenceTimelineEntry(date: Date(), entity: .previewWithSuccess)
}

#Preview("systemSmall failure", as: .systemSmall) {
    AbstinenceWidget()
} timeline: {
    AbstinenceTimelineEntry(date: Date(), entity: .previewWithFailure)
}

#Preview("systemSmall nil", as: .systemSmall) {
    AbstinenceWidget()
} timeline: {
    AbstinenceTimelineEntry(date: Date(), entity: nil)
}

// MARK: Other

#Preview("inprogress", as: .systemMedium) {
    AbstinenceWidget()
} timeline: {
    AbstinenceTimelineEntry(date: Date(), entity: .previewWithInProgress)
}

#Preview("success", as: .systemMedium) {
    AbstinenceWidget()
} timeline: {
    AbstinenceTimelineEntry(date: Date(), entity: .previewWithSuccess)
}

#Preview("failure", as: .systemMedium) {
    AbstinenceWidget()
} timeline: {
    AbstinenceTimelineEntry(date: Date(), entity: .previewWithFailure)
}

#Preview("nil", as: .systemMedium) {
    AbstinenceWidget()
} timeline: {
    AbstinenceTimelineEntry(date: Date(), entity: nil)
}

extension AbstinenceInformation {
    static var previewWithInProgress: Self {
        .init(
            title: "禁欲タイトル",
            detail: "禁欲詳細",
            targetDays: 10,
            scheduledReportDate: DateUtils.add(hours: 3, to: Date())!,
            penaltyInfo: .freePenaltyInfo(),
            startDate: DateUtils.add(days: -1, to: Date())!
        )
    }

    static var previewWithSuccess: Self {
        var info: Self = .init(
            title: "禁欲タイトル",
            detail: "禁欲詳細",
            targetDays: 1,
            scheduledReportDate: DateUtils.add(hours: 3, to: Date())!,
            penaltyInfo: .freePenaltyInfo(),
            startDate: DateUtils.add(days: -1, to: Date())!
        )
        info.progressStatus = .success
        return info
    }

    static var previewWithFailure: Self {
        var info: Self = .init(
            title: "禁欲タイトル",
            detail: "禁欲詳細",
            targetDays: 1,
            scheduledReportDate: DateUtils.add(hours: 3, to: Date())!,
            penaltyInfo: .freePenaltyInfo(),
            startDate: DateUtils.add(days: -1, to: Date())!
        )
        info.progressStatus = .penaltyPaidForFailure
        return info
    }
}
