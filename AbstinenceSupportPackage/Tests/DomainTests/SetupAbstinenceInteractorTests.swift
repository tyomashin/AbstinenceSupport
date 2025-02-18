// Created by okazakishinya on 2025/02/19.

import Foundation
import Testing
import Dependencies
@testable import Domain
@testable import Common
@testable import TestHelper

struct SetupAbstinenceInteractorTests {

    var interactor: SetupAbstinenceInteractor!
    let attManagerStub: ATTManagerStub
    let userNotificationsHelperStub: UserNotificationsHelperStub
    
    init() {
        self.attManagerStub = .init()
        self.userNotificationsHelperStub = .init()
        self.interactor = withDependencies {
            $0.attManager = attManagerStub
            $0.userNotificationsHelper = userNotificationsHelperStub
        } operation: {
            SetupAbstinenceInteractor()
        }
    }
    
    @Test("ATT権限が未設定の場合、ATT権限要求が実施されること")
    func requestedATTAuthWhenNotDetermined() async throws {
        attManagerStub.testATTStatus = .notDetermined
        
        await confirmation(expectedCount: 1) { handler in
            attManagerStub.onCalledRequetAuth = {
                handler()
            }
            await interactor.execute()
        }
    }
    
    @Test("通知権限が未設定の場合、通知権限要求が実施されること")
    func requestedNotificationAuthWhenNotDetermined() async throws {
        userNotificationsHelperStub.testAuthorizationStatus = .notDetermined
        
        await confirmation(expectedCount: 1) { handler in
            userNotificationsHelperStub.onCalledRequetAuth = {
                handler()
            }
            await interactor.execute()
        }
    }

    @Test("通知権限もATT権限も設定済みの場合、権限要求されないこと")
    func notRequested() async throws {
        userNotificationsHelperStub.testAuthorizationStatus = .authorized
        attManagerStub.testATTStatus = .authorized

        await confirmation(expectedCount: 0) { handler in
            attManagerStub.onCalledRequetAuth = {
                handler()
            }
            userNotificationsHelperStub.onCalledRequetAuth = {
                handler()
            }
            await interactor.execute()
        }
    }
}
