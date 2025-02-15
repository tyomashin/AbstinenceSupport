// Created by okazakishinya on 2025/02/16.

import Foundation
import StoreKit
import StoreKitTest
import Infrastructure
import Interface

final class StoreKitHelperStub: StoreKitHelperProtocol, @unchecked Sendable {

    var purchaseResult: Result<Product.PurchaseResult, Error>!
    let session: SKTestSession

    init(configURL: URL) {
        // StoreKit configuration file を指定する
        session = try! SKTestSession(contentsOf: configURL)
        // テスト間で副作用が起きないように初期化
        session.resetToDefaultState()
        session.clearTransactions()
        // 課金ダイアログを表示しない
        session.disableDialogs = true
        session.locale = Locale(identifier: "ja_JP")
    }

    func fetchAllProducts() async throws -> [Product] {
        try await Product.products(for: PurchaseProductIDs.enableIDs)
    }

    func purchase(_ product: Product) async throws -> Product.PurchaseResult {
        switch purchaseResult! {
        case .success(let result):
            return result
        case .failure(let failure):
            throw failure
        }
    }
}
