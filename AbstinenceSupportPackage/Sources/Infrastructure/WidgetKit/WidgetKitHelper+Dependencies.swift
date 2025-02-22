// Created by okazakishinya on 2025/02/22.

import Foundation
import Dependencies
import Interface

enum WidgetKitHelperKey: DependencyKey {
    public static let liveValue: any WidgetKitHelperProtocol = WidgetKitHelper()
}

extension DependencyValues {
    public var widgetKitHelper: any WidgetKitHelperProtocol {
        get { self[WidgetKitHelperKey.self] }
        set { self[WidgetKitHelperKey.self] = newValue }
    }
}
