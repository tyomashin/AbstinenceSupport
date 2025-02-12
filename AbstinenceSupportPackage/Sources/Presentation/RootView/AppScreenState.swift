// Created by okazakishinya on 2025/02/13.

import Foundation
import Entity

enum AppScreenState: Sendable {
    case onboarding
    case top(abstinenceInfo: AbstinenceInformation)
    case abstinenceStart
    case abstinenceFailure(abstinenceInfo: AbstinenceInformation)
}
