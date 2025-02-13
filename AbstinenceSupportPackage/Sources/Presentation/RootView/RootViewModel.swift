// Created by okazakishinya on 2025/02/13.

import Foundation
import SwiftUI
import Interface
import Entity

public final class RootViewModel: RootViewModelProtocol {

    @Published public var appTransitionState: AppTransitionState?

    public init() {}

    public func completedOnboarding() {
        appTransitionState = .abstinenceStart
    }
}
