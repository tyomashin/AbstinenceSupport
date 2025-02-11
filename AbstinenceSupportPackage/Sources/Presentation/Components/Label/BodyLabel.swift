// Created by okazakishinya on 2025/02/10.

import SwiftUI
import Common

public struct BodyLabel: View {

    let text: LocalizedString
    let colorAssets: ColorAssets

    public init(_ text: LocalizedString, colorAssets: ColorAssets = ColorAssets.subText) {
        self.text = text
        self.colorAssets = colorAssets
    }

    public var body: some View {
        Text(text.localizedString)
            .foregroundStyle(colorAssets.color)
            .font(.body)
            .fontWeight(.regular)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    BodyLabel(.anyText("サンプル"))
}
