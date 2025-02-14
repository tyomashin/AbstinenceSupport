// Created by okazakishinya on 2025/02/15.

import Foundation
import AppTrackingTransparency
import Interface

struct ATTManager: ATTManagerProtocol {
    func trackingAuthorizationStatus() -> ATTrackingManager.AuthorizationStatus {
        ATTrackingManager.trackingAuthorizationStatus
    }

    func requestTrackingAuthorization() async -> ATTrackingManager.AuthorizationStatus {
        await ATTrackingManager.requestTrackingAuthorization()
    }
}
