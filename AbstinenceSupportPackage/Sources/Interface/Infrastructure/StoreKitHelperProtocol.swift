// Created by okazakishinya on 2025/02/15.

import Foundation
import StoreKit

/// StoreKit に対する各種操作
public protocol StoreKitHelperProtocol: Sendable {
    /// すべての商品を取得する
    func fetchAllProducts() async throws -> [Product]
    /// 商品を購入する
    /// - Parameter product: 購入する商品
    func purchase(_ product: Product) async throws -> Product.PurchaseResult
}
