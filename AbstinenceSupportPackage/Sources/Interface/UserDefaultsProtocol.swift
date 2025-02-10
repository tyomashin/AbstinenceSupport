// Created by okazakishinya on 2025/02/10.

import Foundation

public protocol UserDefaultsHelperProtocol: Sendable {
    /// 初回起動フラグ
    func setIsFirstLaunch(_ value: Bool) async
    func getIsFirstLaunch() async -> Bool
}
