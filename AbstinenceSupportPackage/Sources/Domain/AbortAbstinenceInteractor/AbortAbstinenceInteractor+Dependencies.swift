// Created by okazakishinya on 2025/02/14.

import Foundation
import Dependencies
import Interface

enum AbortAbstinenceInteractorKey: DependencyKey {
    public static let liveValue: any AbortAbstinenceUseCase = AbortAbstinenceInteractor()
}

extension DependencyValues {
    public var abortAbstinenceInteractor: any AbortAbstinenceUseCase {
        get { self[AbortAbstinenceInteractorKey.self] }
        set { self[AbortAbstinenceInteractorKey.self] = newValue }
    }
}
