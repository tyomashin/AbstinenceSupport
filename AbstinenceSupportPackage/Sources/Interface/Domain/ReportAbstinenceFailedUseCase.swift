// Created by okazakishinya on 2025/02/19.

import Foundation
import Entity

/// 禁欲失敗報告された際に禁欲ステータスを更新する
public protocol ReportAbstinenceFailedUseCase: Sendable {
    func execute(with abstinenceInformation: AbstinenceInformation) async -> AbstinenceInformation
}
