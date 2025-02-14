// Created by okazakishinya on 2025/02/14.

import Foundation
import Entity

/// アプリ起動時シーケンスを実施し、アプリ起動時に表示する画面を返却する
public protocol StartupSequenceUseCase: Sendable {
    func execute(currentDate: Date) async -> AppTransitionState
}
