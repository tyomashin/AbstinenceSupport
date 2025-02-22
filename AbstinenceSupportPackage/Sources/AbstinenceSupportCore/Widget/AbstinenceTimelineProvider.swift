// Created by okazakishinya on 2025/02/21.

import Foundation
import WidgetKit
import Entity
import Domain
import Dependencies

/// TimeLineEntry を生成する TimelineProvider 定義
struct AbstinenceTimelineProvider: TimelineProvider {

    private let placeholderEntry = AbstinenceTimelineEntry(date: Date(), entity: nil)

    /// WidgetKit が初回に表示するウィジェットのプレースホルダーを返却
    func placeholder(in context: Context) -> AbstinenceTimelineEntry {
        placeholderEntry
    }

    /// 現在ウィジェットに表示する TimeLineEntry を返却する
    func getSnapshot(in context: Context, completion: @escaping @Sendable (AbstinenceTimelineEntry) -> Void) {
        Task {
            completion(.init(date: Date(), entity: await currentEntity()))
        }
    }

    /// 現在と未来の TimeLineEntry 配列を生成する TimeLine を返却する
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<AbstinenceTimelineEntry>) -> Void) {
        Task {
            if let entity = await currentEntity() {
                let timeline = Timeline(
                    entries: [
                        AbstinenceTimelineEntry(date: Date(), entity: entity),
                        AbstinenceTimelineEntry(date: entity.nextReportStartDate, entity: entity),
                        AbstinenceTimelineEntry(date: entity.nextReportEndDate, entity: entity),
                    ],
                    policy: .atEnd
                )
                completion(timeline)
            } else {
                // 禁欲を開始していない場合、次回開始時に WidgetKit に Timeline 生成要求をするため、TimelineReloadPolicy.never を指定
                completion(
                    .init(entries: [.init(date: Date(), entity: nil)], policy: .never)
                )
            }
        }
    }

    fileprivate func currentEntity() async -> AbstinenceInformation? {
        @Dependency(\.fetchAbstinenceInfoInteractor) var fetchAbstinenceInfoInteractor
        return await fetchAbstinenceInfoInteractor.execute()
    }
}
