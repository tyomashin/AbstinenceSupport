// Created by okazakishinya on 2025/02/15.

import Foundation
import UserNotifications
import Interface

struct UserNotificationsHelper: UserNotificationsHelperProtocol {

    func getAuthorizationStatus() async -> UNAuthorizationStatus {
        await UNUserNotificationCenter.current().notificationSettings().authorizationStatus
    }

    func requestAuthorization() async -> Bool {
        do {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            return try await UNUserNotificationCenter.current().requestAuthorization(options: authOptions)
        } catch {
            return false
        }
    }

    func scheduleNotification(id: String, title: String, body: String?, date: Date) async {
        guard await getAuthorizationStatus() == .authorized else { return }

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body ?? ""
        content.sound = .default

        let dateComponents = Calendar.current.dateComponents(in: .current, from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        do {
            try await UNUserNotificationCenter.current().add(request)
        } catch {
            print("failed scheduleNotification: \(error)")
        }
    }

    func removeAllScheduledNotifications() async {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
