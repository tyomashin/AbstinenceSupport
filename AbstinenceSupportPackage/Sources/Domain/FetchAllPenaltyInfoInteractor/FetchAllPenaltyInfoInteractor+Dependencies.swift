// Created by okazakishinya on 2025/02/17.

import Foundation
import Dependencies
import Interface

enum FetchAllPenaltyInfoInteractorKey: DependencyKey {
    public static let liveValue: any FetchAllPenaltyInfoUseCase = FetchAllPenaltyInfoInteractor()
}

extension DependencyValues {
    public var fetchAllPenaltyInfoInteractor: any FetchAllPenaltyInfoUseCase {
        get { self[FetchAllPenaltyInfoInteractorKey.self] }
        set { self[FetchAllPenaltyInfoInteractorKey.self] = newValue }
    }
}
