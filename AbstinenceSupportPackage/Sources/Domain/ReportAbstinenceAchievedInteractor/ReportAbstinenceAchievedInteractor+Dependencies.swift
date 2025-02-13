// Created by okazakishinya on 2025/02/14.

import Foundation
import Dependencies
import Interface

enum ReportAbstinenceAchievedInteractorKey: DependencyKey {
    public static let liveValue: any ReportAbstinenceAchievedUseCase = ReportAbstinenceAchievedInteractor()
}

extension DependencyValues {
    public var reportAbstinenceAchievedInteractor: any ReportAbstinenceAchievedUseCase {
        get { self[ReportAbstinenceAchievedInteractorKey.self] }
        set { self[ReportAbstinenceAchievedInteractorKey.self] = newValue }
    }
}
