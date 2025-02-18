// Created by okazakishinya on 2025/02/19.

import Foundation
import Interface
import AppTrackingTransparency

final class ATTManagerStub: ATTManagerProtocol, @unchecked Sendable {

    var testATTStatus: ATTrackingManager.AuthorizationStatus = .notDetermined
    var onCalledRequetAuth: (() -> Void)?

    func trackingAuthorizationStatus() -> ATTrackingManager.AuthorizationStatus {
        testATTStatus
    }

    func requestTrackingAuthorization() async -> ATTrackingManager.AuthorizationStatus {
        onCalledRequetAuth?()
        return .authorized
    }

}
