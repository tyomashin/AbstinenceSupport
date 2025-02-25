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
    let upsertAbstinenceInfoInteractorStub: UpsertAbstinenceInfoInteractorStub
    let userNotificationsHelperStub: UserNotificationsHelperStub
    var testEntity = AbstinenceInformation(title: "sample", detail: nil, targetDays: 0, scheduledReportDate: Date(), startDate: Date())
    
    init() {
        self.upsertAbstinenceInfoInteractorStub = UpsertAbstinenceInfoInteractorStub()
        self.userNotificationsHelperStub = UserNotificationsHelperStub()
        interactor = withDependencies {
            $0.upsertAbstinenceInfoInteractor = upsertAbstinenceInfoInteractorStub
            $0.userNotificationsHelper = userNotificationsHelperStub
        } operation: {
            ReportAbstinenceFailedInteractor()
        }
    }
    
    @Test("失敗ステータスに更新されていることを確認")
    func updateFailureStatus() async throws {
        await confirmation(expectedCount: 1) { handler in
            upsertAbstinenceInfoInteractorStub.onCalled = { _ in
                handler()
            }
            let result = await interactor.execute(with: testEntity)
            #expect(result.progressStatus == .penaltyUnpaidForFailure)
        }
    }
    
    @Test("スケジュールされた通知削除が実行されていることを確認")
    func removeAllScheduledNotificationsIfSuccess() async throws {
        await confirmation(expectedCount: 1) { handler in
            userNotificationsHelperStub.onCalledRemoveAllNotification = {
                handler()
            }
            _ = await interactor.execute(with: testEntity)
        }
    }
}
