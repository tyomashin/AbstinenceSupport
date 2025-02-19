// Created by okazakishinya on 2025/02/14.

import Foundation
import Dependencies
import Interface

enum ReportAbstinenceFailedInteractorKey: DependencyKey {
    public static let liveValue: any ReportAbstinenceFailedUseCase = ReportAbstinenceFailedInteractor()
}

extension DependencyValues {
    public var reportAbstinenceFailedInteractorKey: any ReportAbstinenceFailedUseCase {
        get { self[ReportAbstinenceFailedInteractorKey.self] }
        set { self[ReportAbstinenceFailedInteractorKey.self] = newValue }
    }
}
