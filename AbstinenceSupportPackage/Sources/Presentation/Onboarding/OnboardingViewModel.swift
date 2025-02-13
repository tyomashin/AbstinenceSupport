// Created by okazakishinya on 2025/02/11.

import Foundation
import SwiftUI
import Interface

final class OnboardingViewModel: OnboardingViewModelProtocol {
    let completionHandler: () -> Void

    init(completionHandler: @escaping () -> Void) {
        self.completionHandler = completionHandler
    }

    func onTapStartButton() {
        completionHandler()
    }
}
