// Created by okazakishinya on 2025/02/24.

import SwiftUI
import Common

struct SplashView: View {

    var body: some View {
        ImageAssets.splashIcon
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200, alignment: .center)
    }
}

#Preview {
    SplashView()
}
