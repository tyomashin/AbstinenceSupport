// Created by okazakishinya on 2025/02/12.

import Foundation
import Dependencies
import Interface

enum UpsertAbstinenceInfoInteractorKey: DependencyKey {
    public static let liveValue: any UpsertAbstinenceInfoUseCase = UpsertAbstinenceInfoInteractor()
}

extension DependencyValues {
    public var upsertAbstinenceInfoInteractor: any UpsertAbstinenceInfoUseCase {
        get { self[UpsertAbstinenceInfoInteractorKey.self] }
        set { self[UpsertAbstinenceInfoInteractorKey.self] = newValue }
    }
}
