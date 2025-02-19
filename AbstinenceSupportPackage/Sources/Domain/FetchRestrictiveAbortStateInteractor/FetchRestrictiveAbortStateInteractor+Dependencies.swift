// Created by okazakishinya on 2025/02/12.

import Foundation
import Dependencies
import Interface

enum FetchRestrictiveAbortStateInteractorKey: DependencyKey {
    public static let liveValue: any FetchRestrictiveAbortStateUseCase = FetchRestrictiveAbortStateInteractor()
}

extension DependencyValues {
    public var fetchRestrictiveAbortStateInteractor: any FetchRestrictiveAbortStateUseCase {
        get { self[FetchRestrictiveAbortStateInteractorKey.self] }
        set { self[FetchRestrictiveAbortStateInteractorKey.self] = newValue }
    }
}
