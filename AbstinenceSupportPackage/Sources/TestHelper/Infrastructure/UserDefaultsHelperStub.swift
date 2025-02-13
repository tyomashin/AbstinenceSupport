// Created by okazakishinya on 2025/02/13.

import Foundation
import Interface

final class UserDefaultsHelperStub: UserDefaultsHelperProtocol, @unchecked Sendable {

    var isFirstLaunch = true

    func setIsFirstLaunch(_ value: Bool) async {
        self.isFirstLaunch = value
    }

    func getIsFirstLaunch() async -> Bool {
        isFirstLaunch
    }
}
