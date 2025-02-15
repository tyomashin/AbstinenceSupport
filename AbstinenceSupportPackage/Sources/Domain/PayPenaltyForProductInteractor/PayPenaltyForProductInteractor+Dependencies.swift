// Created by okazakishinya on 2025/02/16.

import Foundation
import Dependencies
import Interface

enum PayPenaltyForProductInteractorKey: DependencyKey {
    public static let liveValue: any PayPenaltyForProductUseCase = PayPenaltyForProductInteractor()
}

extension DependencyValues {
    public var payPenaltyForProductInteractor: any PayPenaltyForProductUseCase {
        get { self[PayPenaltyForProductInteractorKey.self] }
        set { self[PayPenaltyForProductInteractorKey.self] = newValue }
    }
}
