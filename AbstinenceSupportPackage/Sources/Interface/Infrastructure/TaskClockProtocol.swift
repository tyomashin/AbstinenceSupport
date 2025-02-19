// Created by okazakishinya on 2025/02/19.

import Foundation

public protocol TaskClockProtocol: Sendable {
    func register(_ task: @escaping @MainActor () -> Void) async
    func unregister() async
}
