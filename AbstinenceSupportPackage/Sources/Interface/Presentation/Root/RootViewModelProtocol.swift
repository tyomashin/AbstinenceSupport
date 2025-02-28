// Created by okazakishinya on 2025/02/13.

import Foundation
import Entity

@MainActor
public protocol RootViewModelProtocol: ObservableObject, Sendable {
    var appTransitionState: AppTransitionState? { get }

    func startupSequenceIfNeeded() async
    func completedOnboarding()
    func completedAbstinenceStart(with info: AbstinenceInformation)
    func notifyChangedAppTransitionState(nextTransition: AppTransitionState?)
}
