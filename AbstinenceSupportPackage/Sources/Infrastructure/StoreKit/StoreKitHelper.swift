// Created by okazakishinya on 2025/02/15.

import Foundation
import StoreKit
import Interface

struct StoreKitHelper: StoreKitHelperProtocol {

    func fetchAllProducts() async throws -> [Product] {
        try await Product.products(for: PurchaseProductIDs.enableIDs)
    }

    func purchase(_ product: Product) async throws -> Product.PurchaseResult {
        try await product.purchase()
    }

}
