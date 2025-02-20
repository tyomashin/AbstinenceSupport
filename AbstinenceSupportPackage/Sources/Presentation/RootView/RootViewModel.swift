// Created by okazakishinya on 2025/02/13.

import Foundation
import SwiftUI
import Dependencies
import Interface
import Entity
import Domain

public final class RootViewModel: RootViewModelProtocol {

    @Published public var appTransitionState: AppTransitionState?
    private var isExecutedStartupSequence = false

    @Dependency(\.startupSequenceInteractor) var startupSequenceInteractor
    @Dependency(\.checkAppTransitionStateInteractor) var checkAppTransitionStateInteractor

    public init() {}

    public func startupSequenceIfNeeded() async {
        guard !isExecutedStartupSequence else { return }
        isExecutedStartupSequence = true
        appTransitionState = await startupSequenceInteractor.execute(currentDate: Date())
    }

    public func completedOnboarding() {
        appTransitionState = .abstinenceStart
    }

    public func completedAbstinenceStart(with info: AbstinenceInformation) {
        appTransitionState = .top(abstinenceInfo: info)
    }

    public func notifyChangedAppTransitionState() {
        Task {
            appTransitionState = await checkAppTransitionStateInteractor.execute()
        }
    }
}
