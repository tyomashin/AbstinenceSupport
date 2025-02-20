// Created by okazakishinya on 2025/02/14.

import Foundation
import Testing
import Dependencies
@testable import Domain
@testable import Entity
@testable import Common
@testable import TestHelper

struct AbortAbstinenceInteractorTests {

    var interactor: AbortAbstinenceInteractor!
    let keyChainHelperStub: KeyChainHelperStub
    let userNotificationsHelperStub: UserNotificationsHelperStub
    var testEntity = AbstinenceInformation(title: "sample", detail: nil, targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
    
    init() {
        self.keyChainHelperStub = KeyChainHelperStub()
        self.userNotificationsHelperStub = UserNotificationsHelperStub()
        interactor = withDependencies {
            $0.keyChainHelper = keyChainHelperStub
            $0.userNotificationsHelper = userNotificationsHelperStub
        } operation: {
            AbortAbstinenceInteractor()
        }
    }
    
    @Test("失敗ステータスに更新されていることを確認")
    func updateFailureStatus() async throws {
        let result = await interactor.execute(with: testEntity, abortedDate: Date())
        #expect(result.progressStatus == .penaltyPaidForFailure)
        #expect(keyChainHelperStub.abstinenceInformation == result)
    }
    
    @Test("スケジュールされた通知削除が実行されていることを確認")
    func removeAllNotification() async throws {
        await confirmation(expectedCount: 1) { handler in
            userNotificationsHelperStub.onCalledRemoveAllNotification = {
                handler()
            }
            _ = await interactor.execute(with: testEntity, abortedDate: Date())
        }
    }
    
    @Test("中止日時が保存されていることを確認")
    func saveAbortedDate() async throws {
        let abortedDate = Date()
        let result = await interactor.execute(with: testEntity, abortedDate: abortedDate)
        #expect(keyChainHelperStub.abortDate == abortedDate)
    }
}
