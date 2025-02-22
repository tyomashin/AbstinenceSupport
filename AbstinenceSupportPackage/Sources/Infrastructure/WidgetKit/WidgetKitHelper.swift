// Created by okazakishinya on 2025/02/22.

import Foundation
import WidgetKit
import Interface

struct WidgetKitHelper: WidgetKitHelperProtocol {
    func reloadAllTimelines() async {
        WidgetCenter.shared.reloadAllTimelines()
    }
}
