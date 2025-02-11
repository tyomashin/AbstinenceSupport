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
        // TODO: オンボーディング完了後の処理を実行する

        completionHandler()
    }
}
