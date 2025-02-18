// Created by okazakishinya on 2025/02/13.

import Foundation
import Interface
import Entity

class RootViewModelPreview: RootViewModelProtocol {
    var appTransitionState: AppTransitionState?
    func startupSequenceIfNeeded() async {}
    func completedOnboarding() {}
    func completedAbstinenceStart(with info: AbstinenceInformation) {}
}

extension RootViewModelProtocol where Self == RootViewModelPreview {
    static var preview: Self {
        RootViewModelPreview()
    }
}
