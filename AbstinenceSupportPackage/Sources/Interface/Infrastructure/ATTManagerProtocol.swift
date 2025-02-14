// Created by okazakishinya on 2025/02/15.

import Foundation
import AppTrackingTransparency

public protocol ATTManagerProtocol: Sendable {
    func trackingAuthorizationStatus() -> ATTrackingManager.AuthorizationStatus
    func requestTrackingAuthorization() async -> ATTrackingManager.AuthorizationStatus
}
