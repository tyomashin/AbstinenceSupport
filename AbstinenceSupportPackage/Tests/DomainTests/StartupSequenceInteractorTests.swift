// Created by okazakishinya on 2025/02/15.

import Foundation
import Testing
import Dependencies
@testable import Domain
@testable import Entity
@testable import Common
@testable import TestHelper

struct StartupSequenceInteractorTests {
    
    var interactor: StartupSequenceInteractor!
    let checkAppTransitionStateInteractorStub: CheckAppTransitionStateInteractorStub
    let fetchAbstinenceInfoInteractorStub: FetchAbstinenceInfoInteractorStub
    let upsertAbstinenceInfoInteractorStub: UpsertAbstinenceInfoInteractorStub
    let userDefaultsHelperStub: UserDefaultsHelperStub
    
    init() {
        checkAppTransitionStateInteractorStub = .init()
        fetchAbstinenceInfoInteractorStub = .init()
        upsertAbstinenceInfoInteractorStub = .init()
        userDefaultsHelperStub = .init()
        
        interactor = withDependencies{
            $0.checkAppTransitionStateInteractor = checkAppTransitionStateInteractorStub
            $0.fetchAbstinenceInfoInteractor = fetchAbstinenceInfoInteractorStub
            $0.upsertAbstinenceInfoInteractor = upsertAbstinenceInfoInteractorStub
            $0.userDefaultsHelper = userDefaultsHelperStub
        } operation: {
            StartupSequenceInteractor()
        }
    }
    
    @Test("初回起動フラグがfalseに更新されること")
    func firstLaunchFlagUpdatedToFalse() async throws {
        userDefaultsHelperStub.isFirstLaunch = true
        _ = await interactor.execute(currentDate: Date())
        #expect(userDefaultsHelperStub.isFirstLaunch == false)
    }
    
    @Test("CheckAppTransitionStateInteractor で取得した現在の禁欲情報が呼び出し元に返却されること", arguments: [
        AppTransitionState.onboarding,
        AppTransitionState.abstinenceStart,
        AppTransitionState.abstinenceFailure(
            abstinenceInfo: .init(title: "sample", targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), progressStatus: .penaltyPaidForFailure, startDate: Date())
        ),
        AppTransitionState.top(
            abstinenceInfo: .init(title: "sample", targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), progressStatus: .penaltyPaidForFailure, startDate: Date())
        )
    ])
    func appTransitionState(currentState: AppTransitionState) async throws {
        checkAppTransitionStateInteractorStub.state = currentState
        let result = await interactor.execute(currentDate: Date())
        #expect(result == currentState)
    }
    
    @Test("禁欲情報が存在する場合、現在日時を元に禁欲ステータスが更新されていること")
    func upsertAbstinenceInfo() async throws {
        var abstinenceInfo = AbstinenceInformation(title: "sample", targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), progressStatus: .penaltyPaidForFailure, startDate: Date())
        let currentDate = Date()
        fetchAbstinenceInfoInteractorStub.abstinenceInformation = abstinenceInfo
        // 評価用に、禁欲ステータスを更新する
        abstinenceInfo.updateProgressStatus(currentDate: currentDate)

        
        await confirmation(expectedCount: 1) { handler in
            // 禁欲情報更新Interactorにコールバックを登録し、正常に呼び出されているかチェック
            upsertAbstinenceInfoInteractorStub.onCalled = { result in
                // 禁欲ステータス更新処理の結果が格納されようとしていることを確認
                #expect(result == abstinenceInfo)
                handler()
            }
            _ = await interactor.execute(currentDate: currentDate)
        }
    }
}
