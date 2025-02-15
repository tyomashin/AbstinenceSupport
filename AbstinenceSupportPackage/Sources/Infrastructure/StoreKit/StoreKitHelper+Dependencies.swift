// Created by okazakishinya on 2025/02/15.

import Foundation
import Dependencies
import Interface

enum StoreKitHelperKey: DependencyKey {
    public static let liveValue: any StoreKitHelperProtocol = StoreKitHelper()
}

extension DependencyValues {
    public var storeKitHelper: any StoreKitHelperProtocol {
        get { self[StoreKitHelperKey.self] }
        set { self[StoreKitHelperKey.self] = newValue }
    }
}
