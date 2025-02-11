// Created by okazakishinya on 2025/02/11.

import Foundation
import Common
import SwiftUI

enum OnbordingSection: Int, CaseIterable {
    case welcome
    case target
    case penalty
    case start

    var buttonTitle: LocalizedString {
        switch self {
        case .welcome, .target, .penalty:
            LocalizedString.onbordingNextButtonTitle
        case .start:
            LocalizedString.onbordingStartButtonTitle
        }
    }

    var pageTitle: LocalizedString {
        switch self {
        case .welcome:
            LocalizedString.onboardingWelcomeTitle
        case .target:
            LocalizedString.onboardingTargetTitle
        case .penalty:
            LocalizedString.onboardingPenaltyTitle
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
        case .penalty:
            LocalizedString.onboardingPenaltyDetail
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
        case .penalty:
            SFSymbols.handThumbsdownCircleFill.swiftUIImage
        case .start:
            SFSymbols.checkmarkCircleFill.swiftUIImage
        }
    }
}
