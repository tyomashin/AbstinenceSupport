// Created by okazakishinya on 2025/02/11.

import SwiftUI

public enum Gradients: CaseIterable {
    case basedBlandColor
    case basedAccentColor
}

extension Gradients {
    public var gradient: Gradient {
        switch self {
        case .basedBlandColor:
            Gradient(
                stops: [
                    .init(color: ColorAssets.subBland.color, location: 0.0),
                    .init(color: ColorAssets.baseWhite.color, location: 1.0),
                ]
            )
        case .basedAccentColor:
            Gradient(
                stops: [
                    .init(color: ColorAssets.subAccent.color, location: 0.0),
                    .init(color: ColorAssets.baseWhite.color, location: 1.0),
                ]
            )
        }
    }
}
