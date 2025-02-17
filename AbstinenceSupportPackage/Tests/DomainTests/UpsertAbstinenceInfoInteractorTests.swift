// Created by okazakishinya on 2025/02/12.

import Foundation
import Testing
import Dependencies
@testable import Domain
@testable import Entity
@testable import TestHelper

struct UpsertAbstinenceInfoInteractorTests {

    var interactor: UpsertAbstinenceInfoInteractor!
    let keyChainHelperStub: KeyChainHelperStub
    
    init() {
        self.keyChainHelperStub = KeyChainHelperStub()
        interactor = withDependencies {
            $0.keyChainHelper = keyChainHelperStub
        } operation: {
            UpsertAbstinenceInfoInteractor()
        }
    }
    
    @Test("禁欲情報を正常に保存できることを確認", arguments: [
        AbstinenceInformation(title: "", detail: nil, targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), progressStatus: .inProgress, startDate: Date())
    ]) func fetch(abstinenceInfo: AbstinenceInformation) async throws {
        await interactor.execute(abstinenceInfo)
        #expect(keyChainHelperStub.readAbstinenceInformation() == abstinenceInfo)
    }

}
