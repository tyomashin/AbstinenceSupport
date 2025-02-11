// Created by okazakishinya on 2025/02/10.

import SwiftUI
import Common

struct OnboardingView: View {

    @State var scrollPosition: OnbordingSection? = .welcome

    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(OnbordingSection.allCases, id: \.self) { section in
                        OnboardingPageView(section: section)
                            .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.top, 20)
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $scrollPosition)
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            bottomButton
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
        }
        .animation(.default, value: scrollPosition)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Gradients.basedBlandColor.gradient.opacity(0.8))
    }

    @ViewBuilder var bottomButton: some View {
        if let scrollPosition {
            BorderButton(scrollPosition.buttonTitle, colorAssets: .baseWhite) {
                switch scrollPosition {
                case .welcome, .target, .penalty:
                    self.scrollPosition = .init(rawValue: scrollPosition.rawValue + 1)
                case .start:
                    // TODO: 画面遷移
                    break
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
