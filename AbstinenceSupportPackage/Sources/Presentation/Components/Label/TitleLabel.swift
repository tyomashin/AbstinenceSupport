// Created by okazakishinya on 2025/02/10.

import SwiftUI
import Common

public struct TitleLabel: View {

    let text: LocalizedString
    let colorAssets: ColorAssets

    public init(_ text: LocalizedString, colorAssets: ColorAssets = ColorAssets.baseText) {
        self.text = text
        self.colorAssets = colorAssets
    }

    public var body: some View {
        Text(text.localizedString)
            .foregroundStyle(colorAssets.color)
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    TitleLabel(.onboarding1Title)
}
