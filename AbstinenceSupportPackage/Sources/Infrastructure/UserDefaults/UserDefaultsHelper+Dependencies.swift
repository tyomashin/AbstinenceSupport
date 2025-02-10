// Created by okazakishinya on 2025/02/10.

import Foundation
import Dependencies
import Interface

enum UserDefaultsHelperKey: DependencyKey {
    public static let liveValue: any UserDefaultsHelperProtocol = UserDefaultsHelper()
}

extension DependencyValues {
    public var userDefaultsHelper: any UserDefaultsHelperProtocol {
        get { self[UserDefaultsHelperKey.self] }
        set { self[UserDefaultsHelperKey.self] = newValue }
    }
}
