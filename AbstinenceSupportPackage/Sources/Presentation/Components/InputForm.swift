// Created by okazakishinya on 2025/02/16.

import Foundation
import Dependencies
import Domain

/// 入力フォーム
protocol InputForm {
    var text: String { get set }
    var error: String? { get set }
    var isError: Bool { get }
}

extension InputForm {
    var isError: Bool { error != nil }
}

/// やめること名称
@MainActor struct AbstinenceNameInputForm: InputForm {
    var text: String
    var error: String?

    @Dependency(\.validateAbstinenceNameInteractor) var validateAbstinenceNameInteractor

    mutating func validate() {
        self.error = validateAbstinenceNameInteractor.execute(text)
    }
}
