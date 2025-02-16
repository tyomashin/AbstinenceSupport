// Created by okazakishinya on 2025/02/16.

import Foundation
import Dependencies
import Interface

enum ValidateAbstinenceNameInteractorKey: DependencyKey {
    public static let liveValue: any ValidateAbstinenceNameUseCase = ValidateAbstinenceNameInteractor()
}

extension DependencyValues {
    public var validateAbstinenceNameInteractor: any ValidateAbstinenceNameUseCase {
        get { self[ValidateAbstinenceNameInteractorKey.self] }
        set { self[ValidateAbstinenceNameInteractorKey.self] = newValue }
    }
}
