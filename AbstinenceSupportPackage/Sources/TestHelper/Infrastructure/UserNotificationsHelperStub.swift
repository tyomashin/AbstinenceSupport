// Created by okazakishinya on 2025/02/19.

import Foundation
import Interface
import UserNotifications

final class UserNotificationsHelperStub: UserNotificationsHelperProtocol, @unchecked Sendable {

    var testAuthorizationStatus: UNAuthorizationStatus = .notDetermined
    var onCalledRequetAuth: (() -> Void)?
    var onCalledRemoveAllNotification: (() -> Void)?
    var onCalledScheduleNotification: (() -> Void)?

    func getAuthorizationStatus() async -> UNAuthorizationStatus {
        testAuthorizationStatus
    }

    func requestAuthorization() async -> Bool {
        onCalledRequetAuth?()
        return true
    }

    func scheduleNotification(id: String, title: String, body: String?, date: Date) async {
        onCalledScheduleNotification?()
    }

    func removeAllScheduledNotifications() async {
        onCalledRemoveAllNotification?()
    }
}
