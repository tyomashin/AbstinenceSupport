// Created by okazakishinya on 2025/02/14.

import Foundation
import Testing
import Dependencies
@testable import Domain
@testable import Entity
@testable import Common
@testable import TestHelper

struct ReportAbstinenceAchievedInteractorTests {

    var interactor: ReportAbstinenceAchievedInteractor!
    let keyChainHelperStub: KeyChainHelperStub
    var testEntity = AbstinenceInformation(title: "sample", detail: nil, targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
    
    init() {
        self.keyChainHelperStub = KeyChainHelperStub()
        interactor = withDependencies {
            $0.keyChainHelper = keyChainHelperStub
        } operation: {
            ReportAbstinenceAchievedInteractor()
        }
    }
    
    @Test("報告日時が正常に保存されていることを確認", arguments: [
        Date(),
        DateUtils.makeDate(year: 2024, month: 1, day: 1)!,
        DateUtils.makeDate(year: 2025, month: 12, day: 31)!,
    ]) func reportAbstinenceAchieved(reportDate: Date) async throws {
        let result = await interactor.execute(with: testEntity, reportDate: reportDate)
        #expect(result.currentReportedDate == reportDate)
        #expect(keyChainHelperStub.abstinenceInformation == result)
    }

    @Test("報告回数が正常に加算されていることを確認") func reportAbstinenceAchieved() async throws {
        let result = await interactor.execute(with: testEntity, reportDate: Date())
        #expect(result.reportedCount == testEntity.reportedCount + 1)
    }
}
