// Created by okazakishinya on 2025/02/19.

import Foundation
import Interface
import Common

actor MinuteTaskClock: TaskClockProtocol {

    var timerTask: Task<Void, Error>?
    var registeredTask: (@MainActor @Sendable () -> Void)?

    func register(_ task: @escaping @MainActor () -> Void) {
        unregister()
        registeredTask = task
        timerTask = Task(priority: .high) {

            let loopTimer = makeLoopTimerStream()
            for try await _ in loopTimer {
                guard !Task.isCancelled else {
                    unregister()
                    break
                }
                await registeredTask?()
            }
        }
    }

    func unregister() {
        registeredTask = nil
        timerTask?.cancel()
        timerTask = nil
    }

    fileprivate func makeLoopTimerStream() -> AsyncThrowingStream<Void, Error> {
        AsyncThrowingStream {
            let startDate = Date()
            var waitTime: Double = 60
            if let nextZeroSeconds = DateUtils.nextZeroSeconds(from: startDate) {
                waitTime = nextZeroSeconds.timeIntervalSince(startDate)
            }
            try await Task.sleep(for: .seconds(waitTime))
        }
    }
}
