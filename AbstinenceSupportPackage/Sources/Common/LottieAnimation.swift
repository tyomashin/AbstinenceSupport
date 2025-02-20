// Created by okazakishinya on 2025/02/18.

import SwiftUI
import Lottie

public enum LottieAnimation: String {
    case abstinenceStart = "AbstinenceStart"
    case celebrate1 = "Celebrate1"
    case celebrate2 = "Celebrate2"
}

public struct AppLottieView: View {

    let animation: LottieAnimation
    let loopMode: LottieLoopMode

    public init(animation: LottieAnimation, loopMode: LottieLoopMode = .loop) {
        self.animation = animation
        self.loopMode = loopMode
    }

    public var body: some View {
        LottieView(animation: .named(animation.rawValue, bundle: .module))
            .playing(loopMode: loopMode)
            .resizable()
            .scaledToFit()
            .frame(alignment: .top)
    }
}

#Preview {
    AppLottieView(animation: .abstinenceStart)
}
