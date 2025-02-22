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
    let widgetKitHelperStub: WidgetKitHelperStub
    
    init() {
        self.keyChainHelperStub = KeyChainHelperStub()
        self.widgetKitHelperStub = WidgetKitHelperStub()
        interactor = withDependencies {
            $0.keyChainHelper = keyChainHelperStub
            $0.widgetKitHelper = widgetKitHelperStub
        } operation: {
            UpsertAbstinenceInfoInteractor()
        }
    }
    
    @Test("禁欲情報を正常に保存できることを確認", arguments: [
        AbstinenceInformation(title: "", detail: nil, targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
    ]) func fetch(abstinenceInfo: AbstinenceInformation) async throws {
        await interactor.execute(abstinenceInfo)
        #expect(keyChainHelperStub.readAbstinenceInformation() == abstinenceInfo)
    }

    @Test("Widget のタイムライン再読み込みが実行されていることを確認", arguments: [
        AbstinenceInformation(title: "", detail: nil, targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
    ]) func reloadWidget(abstinenceInfo: AbstinenceInformation) async throws {
        await confirmation(expectedCount: 1) { handler in
            widgetKitHelperStub.onCalledReloadAllTimelines = {
                handler()
            }
            await interactor.execute(abstinenceInfo)
        }
    }
}
