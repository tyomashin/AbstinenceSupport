// Created by okazakishinya on 2025/02/19.

import Foundation
import SwiftUI

public enum LabelAlignment {
    case center
    case leading

    var alignment: Alignment {
        switch self {
        case .center:
            .center
        case .leading:
            .leading
        }
    }

    var textAlignment: TextAlignment {
        switch self {
        case .center:
            .center
        case .leading:
            .leading
        }
    }
}
