// Created by okazakishinya on 2025/02/23.

import Foundation
import Testing
import Dependencies
@testable import Domain
@testable import Entity
@testable import Common
@testable import TestHelper

struct RegisterAbstinenceNotificationInteractorTests {

    var interactor: RegisterAbstinenceNotificationInteractor!
    let fetchAbstinenceInfoInteractorStub: FetchAbstinenceInfoInteractorStub
    let userNotificationsHelperStub: UserNotificationsHelperStub
    var testEntity = AbstinenceInformation(title: "sample", detail: nil, targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
    
    init() {
        self.fetchAbstinenceInfoInteractorStub = .init()
        self.userNotificationsHelperStub = UserNotificationsHelperStub()
        interactor = withDependencies {
            $0.fetchAbstinenceInfoInteractor = fetchAbstinenceInfoInteractorStub
            $0.userNotificationsHelper = userNotificationsHelperStub
        } operation: {
            RegisterAbstinenceNotificationInteractor()
        }
    }

    @Test("禁欲情報のステータスが進行中の場合、通知スケジュールされること")
    mutating func scheduleNormal() async throws {
        testEntity.progressStatus = .inProgress
        fetchAbstinenceInfoInteractorStub.abstinenceInformation = testEntity
        
        await confirmation(expectedCount: 2) { handler in
            userNotificationsHelperStub.onCalledScheduleNotification = {
                handler()
            }
            await interactor.execute()
        }
    }
    
    @Test("禁欲情報が存在しない場合、通知スケジュールされないこと")
    func notScheduedIfAbstinenceNotExist() async throws {
        fetchAbstinenceInfoInteractorStub.abstinenceInformation = nil
        
        await confirmation(expectedCount: 0) { handler in
            userNotificationsHelperStub.onCalledScheduleNotification = {
                handler()
            }
            await interactor.execute()
        }
    }
    
    @Test("禁欲ステータスが進行中以外の場合、通知スケジュールされないこと", arguments: [
        AbstinenceProgressStatus.penaltyPaidForFailure,
        AbstinenceProgressStatus.penaltyUnpaidForFailure,
        AbstinenceProgressStatus.success
    ])
    mutating func notScheduedIfAbstinenceStatusNotInProgress(status: AbstinenceProgressStatus) async throws {
        testEntity.progressStatus = status
        fetchAbstinenceInfoInteractorStub.abstinenceInformation = testEntity
        
        await confirmation(expectedCount: 0) { handler in
            userNotificationsHelperStub.onCalledScheduleNotification = {
                handler()
            }
            await interactor.execute()
        }
    }
}
