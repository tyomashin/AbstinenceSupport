// Created by okazakishinya on 2025/02/11.

import Foundation
import Dependencies
import Interface

enum KeyChainHelperKey: DependencyKey {
    public static let liveValue: any KeyChainHelperProtocl = KeyChainHelper()
}

extension DependencyValues {
    public var keyChainHelper: any KeyChainHelperProtocl {
        get { self[KeyChainHelperKey.self] }
        set { self[KeyChainHelperKey.self] = newValue }
    }
}
