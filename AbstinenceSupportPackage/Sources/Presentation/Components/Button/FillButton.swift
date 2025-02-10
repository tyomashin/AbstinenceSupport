// Created by okazakishinya on 2025/02/10.

import SwiftUI
import Common

public struct FillButton: View {

    @Environment(\.isEnabled) var isEnabled: Bool
    let title: LocalizedString
    let colorAssets: ColorAssets
    let tapAction: () -> Void

    public init(_ title: LocalizedString, colorAssets: ColorAssets = ColorAssets.baseBland, tapAction: @escaping () -> Void) {
        self.title = title
        self.colorAssets = colorAssets
        self.tapAction = tapAction
    }

    public var body: some View {
        Button(action: tapAction) {
            Text(title.localizedString)
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .font(.body)
                .fontWeight(.bold)
                .foregroundStyle(ColorAssets.baseWhite.color)
                .frame(maxWidth: .infinity)
        }
        .background(isEnabled ? colorAssets.color : ColorAssets.baseDisabled.color)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    VStack {
        FillButton(.onboarding1Title, tapAction: {})
        FillButton(.onboarding1Title, colorAssets: ColorAssets.baseAccent, tapAction: {})
        FillButton(.onboarding1Title, tapAction: {})
            .environment(\.isEnabled, false)
        FillButton(.onboarding1Title, colorAssets: ColorAssets.baseAccent, tapAction: {})
            .environment(\.isEnabled, false)
    }
    .padding()
}
