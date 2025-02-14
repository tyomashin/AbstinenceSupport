// Created by okazakishinya on 2025/02/15.

import Foundation
import Dependencies
import Interface

enum ATTManagerKey: DependencyKey {
    public static let liveValue: any ATTManagerProtocol = ATTManager()
}

extension DependencyValues {
    public var attManager: any ATTManagerProtocol {
        get { self[ATTManagerKey.self] }
        set { self[ATTManagerKey.self] = newValue }
    }
}
