// Created by okazakishinya on 2025/02/16.

import Foundation

public protocol ValidateAbstinenceNameUseCase: Sendable {
    func execute(_ text: String) -> String?
}
