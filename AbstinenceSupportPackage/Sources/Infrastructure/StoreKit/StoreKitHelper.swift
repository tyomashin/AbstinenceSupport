// Created by okazakishinya on 2025/02/15.

import Foundation
import StoreKit
import Interface

actor StoreKitHelper: StoreKitHelperProtocol {

    func fetchAllProducts() async throws -> [Product] {
        try await Product.products(for: PurchaseProductIDs.enableIDs)
    }

    func purchase(_ product: Product) async throws -> Product.PurchaseResult {
        let result = try await product.purchase()
        switch result {
        case .success(let verificationResult):
            switch verificationResult {
            case .unverified:
                return result
            case .verified(let transaction):
                await transaction.finish()
                return result
            }
        case .userCancelled, .pending:
            return result
        @unknown default:
            return result
        }
    }

    func subscriptionTransactionUpdate() async {
        Task(priority: .background) {
            for await verificationResult in Transaction.updates {
                switch verificationResult {
                case .unverified:
                    continue
                case .verified(let transaction):
                    await transaction.finish()
                }
            }
        }
    }
}
