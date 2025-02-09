// Created by okazakishinya on 2025/02/10.

import Foundation
import UIKit
import SwiftUI

public enum SFSymbols: String, CaseIterable {
    case checkmarkCircle = "checkmark.circle"

    public var swiftUIImage: Image {
        .init(systemName: rawValue)
    }
}

#Preview {
    VStack(spacing: 8) {
        ForEach(SFSymbols.allCases, id: \.self) { symbol in
            symbol.swiftUIImage
        }
    }
}
