// Created by okazakishinya on 2025/02/10.

import SwiftUI
import Common

public struct HeadlineLabel: View {

    let text: LocalizedString
    let colorAssets: ColorAssets

    public init(_ text: LocalizedString, colorAssets: ColorAssets = ColorAssets.baseText) {
        self.text = text
        self.colorAssets = colorAssets
    }

    public var body: some View {
        Text(text.localizedString)
            .foregroundStyle(colorAssets.color)
            .font(.headline)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
    }
}

#Preview {
    HeadlineLabel(.anyText("サンプル"))
}
