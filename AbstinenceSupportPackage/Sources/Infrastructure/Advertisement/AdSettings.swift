// Created by okazakishinya on 2025/02/25.

import Foundation

@MainActor public struct AdSettings: Sendable {
    public static var currentAdUnitID: AdUnitID = .makeTestInscance()
}

public struct AdUnitID: Sendable {

    public let rewardID: String

    public init(rewardID: String) {
        self.rewardID = rewardID
    }

    public static func makeTestInscance() -> Self {
        .init(
            rewardID: "ca-app-pub-3940256099942544/1712485313"
        )
    }
}
