// Created by okazakishinya on 2025/02/11.

import SwiftUI

public enum Gradients: CaseIterable {
    case basedBlandColor
    case basedAccentColor
}

extension Gradients {
    public var gradient: AnyGradient {
        switch self {
        case .basedBlandColor:
            ColorAssets.subBland.color.gradient
        case .basedAccentColor:
            AnyGradient(
                Gradient(
                    stops: [
                        .init(color: ColorAssets.subAccent.color, location: 0.0),
                        .init(color: ColorAssets.baseWhite.color, location: 1.0),
                    ]
                )
            )
        }
    }
}
