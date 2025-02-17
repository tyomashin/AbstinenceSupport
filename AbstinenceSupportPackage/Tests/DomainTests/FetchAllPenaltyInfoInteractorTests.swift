// Created by okazakishinya on 2025/02/17.

import Foundation
import Testing
import Dependencies
@testable import Domain
@testable import Entity
@testable import TestHelper
@testable import Common

struct FetchAllPenaltyInfoInteractorTests {

    var interactor: FetchAllPenaltyInfoInteractor!
    let storeKitHelperStub: StoreKitHelperStub
    
    init() {
        let url = ResourceURL.url(forResource: "LocalProducts", withExtension: "storekit")!
        storeKitHelperStub = .init(configURL: url)
        interactor = withDependencies {
            $0.storeKitHelper = storeKitHelperStub
        } operation: {
            FetchAllPenaltyInfoInteractor()
        }
    }
    
    @Test("StoreKit から取得した課金アイテムが正常にペナルティ情報に変換されて返却されていること")
    func normal() async throws {
        let allProducts = (try await storeKitHelperStub.fetchAllProducts()).sorted(by: { $0.price < $1.price })
        let expectedResults = [PenaltyInfo.freePenaltyInfo()] + allProducts.map{
            .init(
                title: LocalizedString.penaltyFeeTitle(price: $0.price.intValue, description: $0.displayName).localizedString,
                detail: $0.description,
                penaltyCategory: .product(productID: $0.id)
            )
        }
        
        let results = await interactor.execute()
        #expect(results.count == expectedResults.count)
        #expect(results == expectedResults)
        
        print("hoge!!!", results)
    }

    @Test("StoreKit の商品取得がエラーになった場合、無料アイテムのみが返却荒れること")
    func storeKitErrorOccured() async throws {
        storeKitHelperStub.isErrorFetchAllProducts = true
        
        let results = await interactor.execute()
        let freePenalty = try #require(results.first)
        #expect(results.count == 1)
        #expect(freePenalty == PenaltyInfo.freePenaltyInfo())
    }
}
