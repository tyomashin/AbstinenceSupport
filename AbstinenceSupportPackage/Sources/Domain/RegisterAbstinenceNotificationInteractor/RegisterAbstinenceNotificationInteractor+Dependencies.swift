// Created by okazakishinya on 2025/02/23.

import Foundation
import Dependencies
import Interface

enum RegisterAbstinenceNotificationInteractorKey: DependencyKey {
    public static let liveValue: any RegisterAbstinenceNotificationUseCase = RegisterAbstinenceNotificationInteractor()
}

extension DependencyValues {
    public var registerAbstinenceNotificationInteractor: any RegisterAbstinenceNotificationUseCase {
        get { self[RegisterAbstinenceNotificationInteractorKey.self] }
        set { self[RegisterAbstinenceNotificationInteractorKey.self] = newValue }
    }
}
