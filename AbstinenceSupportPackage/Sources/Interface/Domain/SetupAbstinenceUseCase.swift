// Created by okazakishinya on 2025/02/18.

import Foundation

/// アプリを利用するためのセットアップを行う
///
/// - Note:
///     トップ画面遷移時に実行する
public protocol SetupAbstinenceUseCase: Sendable {
    func execute() async
}
