// Created by okazakishinya on 2025/02/17.

import Foundation
import Testing
import Dependencies
@testable import Domain
@testable import Entity
@testable import TestHelper
@testable import Common

struct FetchRestrictiveAbortStateInteractorTests {

    var interactor: FetchRestrictiveAbortStateInteractor!
    let keyChainHelperStub: KeyChainHelperStub
    
    init() {
        self.keyChainHelperStub = KeyChainHelperStub()
        interactor = withDependencies {
            $0.keyChainHelper = keyChainHelperStub
        } operation: {
            FetchRestrictiveAbortStateInteractor()
        }
    }
    
    @Test("一度も禁欲中止されていなければ、禁欲中止制限なし（unrestricted）が返却されること")
    func unrestrictedWhenNeverAborted() async throws {
        keyChainHelperStub.abortDate = nil
        let result = await interactor.execute(with: Date())
        #expect(result == .unrestricted)
    }
    
    @Test("前回禁欲中止されてから30日以上経過している場合、禁欲中止制限なし（unrestricted）が返却されること", arguments: [
        30, 40, 100
    ])
    func unrestrictedWhen30DaysPassed(elapsedDays: Int) async throws {
        let abortDate = Date()
        let currentDate = DateUtils.add(days: elapsedDays, to: abortDate)!
        keyChainHelperStub.abortDate = abortDate
        let result = await interactor.execute(with: currentDate)
        #expect(result == .unrestricted)
    }
    
    @Test("前回禁欲中止されてから30日経過していない場合、禁欲中止制限あり（restricted）が返却されること", arguments: [
        0, 20, 29
    ])
    func restricted(elapsedDays: Int) async throws {
        let abortDate = Date()
        let currentDate = DateUtils.add(days: elapsedDays, to: abortDate)!
        keyChainHelperStub.abortDate = abortDate
        let result = await interactor.execute(with: currentDate)
        guard case .restricted(releaseDays: let releaseDays) = result else {
            #expect(Bool(false))
            return
        }
        #expect(releaseDays == 30 - elapsedDays)
    }
}
