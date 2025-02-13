// Created by okazakishinya on 2025/02/10.

import Foundation
import Interface

@MainActor struct UserDefaultsHelper: UserDefaultsHelperProtocol {
    @UserDefaultsWrapper(key: "isFirstLaunch", defaultValue: true)
    static var isFirstLaunch: Bool

    func setIsFirstLaunch(_ value: Bool) async {
        Self.isFirstLaunch = value
    }

    func getIsFirstLaunch() async -> Bool {
        Self.isFirstLaunch
    }
}
