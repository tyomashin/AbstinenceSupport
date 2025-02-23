// Created by okazakishinya on 2025/02/23.

import Foundation
import Entity

/// 禁欲の次回報告開始日時・終了日時の通知を登録する
public protocol RegisterAbstinenceNotificationUseCase: Sendable {
    func execute() async
}
