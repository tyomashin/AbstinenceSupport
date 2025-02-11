// Created by okazakishinya on 2025/02/11.

import Foundation

@MainActor
public protocol OnboardingViewModelProtocol: ObservableObject {
    func onTapStartButton()
}
