// Created by okazakishinya on 2025/02/15.

import Testing
import StoreKitTest
@testable import Infrastructure
@testable import TestHelper

@Suite(.serialized)
struct StoreKitHelperTests {

    let session: SKTestSession
    
    init() throws {
        // StoreKit configuration file を指定する
        let url = ResourceURL.url(forResource: "LocalProducts", withExtension: "storekit")!
        session = try SKTestSession(contentsOf: url)
        // テスト間で副作用が起きないように初期化
        session.resetToDefaultState()
        session.clearTransactions()
        // 課金ダイアログを表示しない
        session.disableDialogs = true
        session.locale = Locale(identifier: "ja_JP")
    }

    @Test("StoreKit で取得した商品数がアプリ内で定義した数と同数であること")
    func fetchAllProducts() async throws {
        let helper = StoreKitHelper()
        let products = try await helper.fetchAllProducts()
        #expect(products.count == PurchaseProductIDs.allCases.count)
    }
    
    /// - Note:
    ///     現状 unknown エラーが発生する.
    ///     シミュレータでは購入処理はできないためかと思われ、問題解決するまでは無効にする
    ///     https://stackoverflow.com/questions/71888027/storekit-storekiterror-unknown-thrown-by-try-await-product-productsfor-product
    @Test("購入処理が正常に終了すること", .disabled())
    func purchase() async throws {
        let helper = StoreKitHelper()
        let product = try #require(try await helper.fetchAllProducts().first)
        let result = try await helper.purchase(product)
        switch result {
        case .success(.verified):
            #expect(true)
        default:
            #expect(Bool(false))
        }
    }
}
