// Created by okazakishinya on 2025/02/14.

import Foundation
import Testing
import Dependencies
@testable import Domain
@testable import Entity
@testable import Common
@testable import TestHelper

struct ReportAbstinenceFailedInteractorTests {

    var interactor: ReportAbstinenceFailedInteractor!
    let keyChainHelperStub: KeyChainHelperStub
    var testEntity = AbstinenceInformation(title: "sample", detail: nil, targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
    
    init() {
        self.keyChainHelperStub = KeyChainHelperStub()
        interactor = withDependencies {
            $0.keyChainHelper = keyChainHelperStub
        } operation: {
            ReportAbstinenceFailedInteractor()
        }
    }
    
    @Test("失敗ステータスに更新されていることを確認")
    func updateFailureStatus() async throws {
        let result = await interactor.execute(with: testEntity)
        #expect(result.progressStatus == .penaltyUnpaidForFailure)
        #expect(keyChainHelperStub.abstinenceInformation == result)
    }
}
