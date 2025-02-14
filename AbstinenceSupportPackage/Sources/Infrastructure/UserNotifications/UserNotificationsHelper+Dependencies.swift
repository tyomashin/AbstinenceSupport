// Created by okazakishinya on 2025/02/15.

import Foundation
import Dependencies
import Interface

enum UserNotificationsHelperKey: DependencyKey {
    public static let liveValue: any UserNotificationsHelperProtocol = UserNotificationsHelper()
}

extension DependencyValues {
    public var userNotificationsHelper: any UserNotificationsHelperProtocol {
        get { self[UserNotificationsHelperKey.self] }
        set { self[UserNotificationsHelperKey.self] = newValue }
    }
}
