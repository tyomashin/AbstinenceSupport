// Created by okazakishinya on 2025/02/17.

import Foundation
import Entity

/// 禁欲を中止できるかどうかの状態を返却する
public protocol FetchRestrictiveAbortStateUseCase: Sendable {
    func execute(with currentDate: Date) async -> RestrictiveAbortState
}
