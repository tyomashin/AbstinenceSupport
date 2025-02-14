// Created by okazakishinya on 2025/02/13.

import Foundation

public enum AppTransitionState: Sendable, Equatable {
    case onboarding
    case top(abstinenceInfo: AbstinenceInformation)
    case abstinenceStart
    case abstinenceFailure(abstinenceInfo: AbstinenceInformation)
}
