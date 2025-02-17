// Created by okazakishinya on 2025/02/17.

import Foundation
import Dependencies
import Infrastructure
import Entity
import Interface
import Common

struct FetchAllPenaltyInfoInteractor: FetchAllPenaltyInfoUseCase {

    @Dependency(\.storeKitHelper) var storeKitHelper

    func execute() async -> [PenaltyInfo] {
        let results = [PenaltyInfo.freePenaltyInfo()]
        guard let products = try? await storeKitHelper.fetchAllProducts() else { return results }
        return results
            + products.sorted(by: { $0.price < $1.price }).map {
                .init(
                    title: LocalizedString.penaltyFeeTitle(price: $0.price.intValue, description: $0.displayName).localizedString,
                    detail: $0.description,
                    penaltyCategory: .product(productID: $0.id)
                )
            }
    }
}
