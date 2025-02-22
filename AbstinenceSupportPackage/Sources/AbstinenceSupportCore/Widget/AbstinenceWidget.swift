// Created by okazakishinya on 2025/02/22.

import Foundation
import SwiftUI
import WidgetKit
import Common

public struct AbstinenceWidget: Widget {
    let kind = "AbstinenceWidget"

    public init() {}

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: AbstinenceTimelineProvider()) { entry in
            AbstinenceWidgetView(entry: entry)
                .containerBackground(for: .widget) {
                    ColorAssets.baseBackground.color
                }
        }
        .configurationDisplayName(LocalizedString.widgetTitle.localizedString)
        .description(LocalizedString.widgetDescription.localizedString)
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
    }
}
