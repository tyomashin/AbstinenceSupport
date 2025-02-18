// Created by okazakishinya on 2025/02/16.

import Foundation
import Testing
import Dependencies
@testable import Domain
@testable import Entity
@testable import Common
@testable import TestHelper
@testable import Infrastructure

struct PayPenaltyForProductInteractorTests {

    var interactor: PayPenaltyForProductInteractor!
    let storeKitHelperStub: StoreKitHelperStub
    let fetchAbstinenceInfoInteractorStub: FetchAbstinenceInfoInteractorStub
    let upsertAbstinenceInfoInteractorStub: UpsertAbstinenceInfoInteractorStub
    
    init() {
        let url = ResourceURL.url(forResource: "LocalProducts", withExtension: "storekit")!
        storeKitHelperStub = .init(configURL: url)
        fetchAbstinenceInfoInteractorStub = .init()
        upsertAbstinenceInfoInteractorStub = .init()
        
        interactor = withDependencies {
            $0.storeKitHelper = storeKitHelperStub
            $0.fetchAbstinenceInfoInteractor = fetchAbstinenceInfoInteractorStub
            $0.upsertAbstinenceInfoInteractor = upsertAbstinenceInfoInteractorStub
        } operation: {
            PayPenaltyForProductInteractor()
        }
    }
    
    @Test("課金商品が存在しない場合は正常終了すること")
    func normalWithNotExistProduct() async throws {
        var info = AbstinenceInformation(title: "", targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
        info.progressStatus = .penaltyUnpaidForFailure
        fetchAbstinenceInfoInteractorStub.abstinenceInformation = info
        
        await confirmation(expectedCount: 1) { handler in
            // ペナルティ支払い後、禁欲ステータスが「支払い済み」に更新されていることを確認
            upsertAbstinenceInfoInteractorStub.onCalled = { updatedInfo in
                #expect(updatedInfo.progressStatus == .penaltyPaidForFailure)
                handler()
            }
            // 正常終了していることを確認
            let result = await interactor.execute(for: "illigal_id")
            switch result {
            case .success:
                #expect(true)
            case .failure:
                #expect(Bool(false))
            }
        }
    }

    
    @Test("課金商品のペナルティ支払い時に .pending ステータスの場合は正常終了すること", arguments: PurchaseProductIDs.allCases.map(\.rawValue))
    func normalWithPending(productID: String) async throws {
        storeKitHelperStub.purchaseResult = .success(.pending)
        var info = AbstinenceInformation(title: "", targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
        info.progressStatus = .penaltyUnpaidForFailure
        fetchAbstinenceInfoInteractorStub.abstinenceInformation = info
        
        await confirmation(expectedCount: 1) { handler in
            // ペナルティ支払い後、禁欲ステータスが「支払い済み」に更新されていることを確認
            upsertAbstinenceInfoInteractorStub.onCalled = { updatedInfo in
                #expect(updatedInfo.progressStatus == .penaltyPaidForFailure)
                handler()
            }
            // 正常終了していることを確認
            let result = await interactor.execute(for: productID)
            switch result {
            case .success:
                #expect(true)
            case .failure:
                #expect(Bool(false))
            }
        }
    }

    @Test("課金商品のペナルティ支払い時にユーザーがキャンセルした場合はエラーとなること", arguments: PurchaseProductIDs.allCases.map(\.rawValue))
    func userCancelled(productID: String) async throws {
        storeKitHelperStub.purchaseResult = .success(.userCancelled)
        var info = AbstinenceInformation(title: "", targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
        info.progressStatus = .penaltyUnpaidForFailure
        fetchAbstinenceInfoInteractorStub.abstinenceInformation = info
        
        await confirmation(expectedCount: 0) { handler in
            // 更新処理が呼ばれていないことを確認
            upsertAbstinenceInfoInteractorStub.onCalled = { _ in
                handler()
            }
            // userCancelled エラーになっていること
            let result = await interactor.execute(for: productID)
            switch result {
            case .success:
                #expect(Bool(false))
            case .failure(let error):
                #expect(error == .userCancelled)
            }
        }
        
    }

}
