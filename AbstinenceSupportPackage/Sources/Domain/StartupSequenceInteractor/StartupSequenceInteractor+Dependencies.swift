// Created by okazakishinya on 2025/02/14.

import Foundation
import Dependencies
import Interface

enum StartupSequenceInteractorKey: DependencyKey {
    public static let liveValue: any StartupSequenceUseCase = StartupSequenceInteractor()
}

extension DependencyValues {
    public var startupSequenceInteractor: any StartupSequenceUseCase {
        get { self[StartupSequenceInteractorKey.self] }
        set { self[StartupSequenceInteractorKey.self] = newValue }
    }
}
