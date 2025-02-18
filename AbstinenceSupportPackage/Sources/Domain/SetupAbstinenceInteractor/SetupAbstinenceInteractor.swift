// Created by okazakishinya on 2025/02/18.

import Foundation
import Dependencies
import Interface
import Infrastructure

struct SetupAbstinenceInteractor: SetupAbstinenceUseCase {

    @Dependency(\.attManager) var attManager
    @Dependency(\.userNotificationsHelper) var userNotificationsHelper

    func execute() async {
        if attManager.trackingAuthorizationStatus() == .notDetermined {
            _ = await attManager.requestTrackingAuthorization()
            try? await Task.sleep(for: .seconds(0.5))
        }
        if await userNotificationsHelper.getAuthorizationStatus() == .notDetermined {
            _ = await userNotificationsHelper.requestAuthorization()
            try? await Task.sleep(for: .seconds(0.5))
        }
    }
}
