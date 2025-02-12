// Created by okazakishinya on 2025/02/12.

import Foundation
import Testing
import Dependencies
@testable import Domain
@testable import Entity
@testable import TestHelper

struct FetchAbstinenceInfoInteractorTests {

    var interactor: FetchAbstinenceInfoInteractor!
    let keyChainHelperStub: KeyChainHelperStub
    
    init() {
        self.keyChainHelperStub = KeyChainHelperStub()
        interactor = withDependencies {
            $0.keyChainHelper = keyChainHelperStub
        } operation: {
            FetchAbstinenceInfoInteractor()
        }
    }
    
    @Test("禁欲情報を正常に取得できることを確認", arguments: [
        nil,
        AbstinenceInformation(title: "", detail: nil, targetDays: 0, scheduledReportDate: Date(), penalties: .free, progressStatus: .inProgress, startDate: Date())
    ]) func fetch(abstinenceInfo: AbstinenceInformation?) async throws {
        keyChainHelperStub.save(abstinenceInformation: abstinenceInfo)
        #expect(await interactor.execute() == abstinenceInfo)
    }

}
