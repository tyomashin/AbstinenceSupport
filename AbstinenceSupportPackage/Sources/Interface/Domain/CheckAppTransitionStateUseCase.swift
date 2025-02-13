// Created by okazakishinya on 2025/02/13.

import Foundation
import Entity

/// 現在の禁欲情報に応じてアプリの遷移先を判定する
public protocol CheckAppTransitionStateUseCase: Sendable {
    func execute() async -> AppTransitionState
}
