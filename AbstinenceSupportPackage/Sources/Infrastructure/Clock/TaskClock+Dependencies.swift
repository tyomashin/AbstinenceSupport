// Created by okazakishinya on 2025/02/19.

import Foundation
import Dependencies
import Interface

enum TaskClockKey: DependencyKey {
    public static let liveValue: any TaskClockProtocol = MinuteTaskClock()
}

extension DependencyValues {
    public var minuteTaskClock: any TaskClockProtocol {
        get { self[TaskClockKey.self] }
        set { self[TaskClockKey.self] = newValue }
    }
}
