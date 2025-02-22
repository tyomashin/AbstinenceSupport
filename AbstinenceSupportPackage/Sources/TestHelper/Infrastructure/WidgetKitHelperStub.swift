// Created by okazakishinya on 2025/02/22.

import Foundation
import Interface

final class WidgetKitHelperStub: WidgetKitHelperProtocol, @unchecked Sendable {

    var onCalledReloadAllTimelines: (() -> Void)?

    func reloadAllTimelines() async {
        onCalledReloadAllTimelines?()
    }
}
