// Created by okazakishinya on 2025/02/17.

import Foundation
import Entity

/// 有料・無料含めた全てのペナルティ情報を返却する
public protocol FetchAllPenaltyInfoUseCase: Sendable {
    func execute() async -> [PenaltyInfo]
}
