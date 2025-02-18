// Created by okazakishinya on 2025/02/19.

import Foundation
import Dependencies
import Interface

enum SetupAbstinenceInteractorKey: DependencyKey {
    public static let liveValue: any SetupAbstinenceUseCase = SetupAbstinenceInteractor()
}

extension DependencyValues {
    public var setupAbstinenceInteractor: any SetupAbstinenceUseCase {
        get { self[SetupAbstinenceInteractorKey.self] }
        set { self[SetupAbstinenceInteractorKey.self] = newValue }
    }
}
