// Created by okazakishinya on 2025/02/19.

import Foundation
import Entity

/// 禁欲処理を中断する
public protocol AbortAbstinenceUseCase: Sendable {
    func execute(with abstinenceInformation: AbstinenceInformation, abortedDate: Date) async -> AbstinenceInformation
}
