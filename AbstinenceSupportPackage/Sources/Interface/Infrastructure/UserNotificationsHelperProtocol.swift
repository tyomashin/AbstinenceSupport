// Created by okazakishinya on 2025/02/15.

import Foundation
import UserNotifications

public protocol UserNotificationsHelperProtocol: Sendable {
    /// 現在の通知設定を取得する
    func getNotificationSettings() async -> UNNotificationSettings
    /// 通知権限要求する
    func requestAuthorization() async -> Bool
    /// 指定日時に通知をスケジュルする
    /// - Parameters:
    ///   - id: 通知ID
    ///   - title: タイトル
    ///   - body: 本文
    ///   - date: 通知日時
    func scheduleNotification(id: String, title: String, body: String?, date: Date) async
    /// スケジュールされている通知を全て削除する
    func removeAllScheduledNotifications() async
}
