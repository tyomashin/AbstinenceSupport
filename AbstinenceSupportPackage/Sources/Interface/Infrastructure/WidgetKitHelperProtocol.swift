// Created by okazakishinya on 2025/02/15.

import Foundation

/// WidgetKit に対する各種操作
public protocol WidgetKitHelperProtocol: Sendable {
    /// Widget のタイムラインを更新する
    func reloadAllTimelines() async
}
