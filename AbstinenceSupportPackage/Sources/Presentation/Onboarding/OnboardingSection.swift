// Created by okazakishinya on 2025/02/11.

import Foundation
import Common
import SwiftUI

enum OnboardingSection: Int, CaseIterable {
    case welcome
    case target
    case start

    var buttonTitle: LocalizedString {
        switch self {
        case .welcome, .target:
            LocalizedString.nextButton
        case .start:
            LocalizedString.onboardingStartButtonTitle
        }
    }

    var pageTitle: LocalizedString {
        switch self {
        case .welcome:
            LocalizedString.onboardingWelcomeTitle
        case .target:
            LocalizedString.onboardingTargetTitle
        case .start:
            LocalizedString.onboardingStartTitle
        }
    }

    var pageDetail: LocalizedString {
        switch self {
        case .welcome:
            LocalizedString.onboardingWelcomeDetail
        case .target:
            LocalizedString.onboardingTargetDetail
        case .start:
            LocalizedString.onboardingStartDetail
        }
    }

    var pageIcon: Image {
        switch self {
        case .welcome:
            SFSymbols.handWaveFill.swiftUIImage
        case .target:
            SFSymbols.personCropCircleFillBadgeCheckmark.swiftUIImage
        case .start:
            SFSymbols.checkmarkCircleFill.swiftUIImage
        }
    }
}
