// Created by okazakishinya on 2025/02/11.

import Foundation
import Interface

class OnboardingViewModelPreview: OnboardingViewModelProtocol {
    func onTapStartButton() {}
}

extension OnboardingViewModelProtocol where Self == OnboardingViewModelPreview {
    static var preview: Self {
        OnboardingViewModelPreview()
    }
}
