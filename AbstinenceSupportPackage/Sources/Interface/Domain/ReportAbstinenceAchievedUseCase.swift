// Created by okazakishinya on 2025/02/14.

import Foundation
import Entity

/// 日々の禁欲達成報告を実施して、禁欲情報を更新する
public protocol ReportAbstinenceAchievedUseCase: Sendable {
    func execute(with abstinenceInformation: AbstinenceInformation, reportDate: Date) async -> AbstinenceInformation
}
