// Created by okazakishinya on 2025/02/15.

import Foundation
import Dependencies
import Interface

enum RewardedAdManagerKey: DependencyKey {
    public static let liveValue: any RewardedAdManagerProtocol = {
        MainActor.assumeIsolated {
            RewardedAdManager()
        }
    }()
}

extension DependencyValues {
    public var rewardedAdManager: any RewardedAdManagerProtocol {
        get { self[RewardedAdManagerKey.self] }
        set { self[RewardedAdManagerKey.self] = newValue }
    }
}
