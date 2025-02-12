// Created by okazakishinya on 2025/02/12.

import Foundation
import Dependencies
import Interface

enum FetchAbstinenceInfoInteractorKey: DependencyKey {
    public static let liveValue: any FetchAbstinenceInfoUseCase = FetchAbstinenceInfoInteractor()
}

extension DependencyValues {
    public var fetchAbstinenceInfoInteractor: any FetchAbstinenceInfoUseCase {
        get { self[FetchAbstinenceInfoInteractorKey.self] }
        set { self[FetchAbstinenceInfoInteractorKey.self] = newValue }
    }
}
