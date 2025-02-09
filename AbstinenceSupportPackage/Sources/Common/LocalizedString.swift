// Created by okazakishinya on 2025/02/09.

import Foundation

public enum LocalizedString {
    case onboarding1Title
}

extension LocalizedString {
    public var localizedString: String {
        switch self {
        case .onboarding1Title:
            String(localized: "onboarding1-title", defaultValue: "禁欲サポートにようこそ")
        }
    }
}
