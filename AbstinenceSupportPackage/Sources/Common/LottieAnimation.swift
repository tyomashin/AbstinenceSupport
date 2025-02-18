// Created by okazakishinya on 2025/02/18.

import SwiftUI
import Lottie

public enum LottieAnimation: String {
    case abstinenceStart = "AbstinenceStart"
}

public struct AppLottieView: View {

    let animation: LottieAnimation

    public init(animation: LottieAnimation) {
        self.animation = animation
    }

    public var body: some View {
        LottieView(animation: .named(animation.rawValue, bundle: .module))
            .playing(loopMode: .loop)
            .scaledToFit()
            .frame(alignment: .top)
    }
}

#Preview {
    AppLottieView(animation: .abstinenceStart)
}
