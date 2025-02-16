// Created by okazakishinya on 2025/02/16.

import Foundation
import Interface
import Dependencies
import Common
import Entity

struct ValidateAbstinenceNameInteractor: ValidateAbstinenceNameUseCase {
    func execute(_ text: String) -> String? {
        guard !text.isEmpty else {
            return ValidationError.empty.error
        }
        return nil
    }
}
