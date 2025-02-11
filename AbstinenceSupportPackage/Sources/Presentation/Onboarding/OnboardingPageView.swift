// Created by okazakishinya on 2025/02/11.

import SwiftUI
import Common

struct OnboardingPageView: View {
    let section: OnbordingSection

    var body: some View {
        VStack(spacing: 40) {
            TitleLabel(section.pageTitle, colorAssets: .baseWhite)

            section
                .pageIcon
                .resizable()
                .scaledToFit()
                .foregroundStyle(ColorAssets.baseWhite.color)
                .frame(width: 60, height: 60)

            HeadlineLabel(section.pageDetail, colorAssets: .baseWhite)
                .padding(.horizontal, 20)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview(".welcome") {
    OnboardingPageView(section: .welcome)
        .background(Gradients.basedBlandColor.gradient.opacity(0.8))
}

#Preview(".target") {
    OnboardingPageView(section: .target)
        .background(Gradients.basedBlandColor.gradient.opacity(0.8))
}

#Preview(".penalty") {
    OnboardingPageView(section: .penalty)
        .background(Gradients.basedBlandColor.gradient.opacity(0.8))
}

#Preview(".start") {
    OnboardingPageView(section: .start)
        .background(Gradients.basedBlandColor.gradient.opacity(0.8))
}
