// Created by okazakishinya on 2025/02/13.

import Foundation
import Dependencies
import Interface

enum CheckAppTransitionStateInteractorKey: DependencyKey {
    public static let liveValue: any CheckAppTransitionStateUseCase = CheckAppTransitionStateInteractor()
}

extension DependencyValues {
    public var checkAppTransitionStateInteractor: any CheckAppTransitionStateUseCase {
        get { self[CheckAppTransitionStateInteractorKey.self] }
        set { self[CheckAppTransitionStateInteractorKey.self] = newValue }
    }
}
