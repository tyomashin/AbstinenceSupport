// Created by okazakishinya on 2025/02/18.

import SwiftUI
import Common

public struct FootnoteLabel: View {

    let text: LocalizedString
    let colorAssets: ColorAssets

    public init(_ text: LocalizedString, colorAssets: ColorAssets = ColorAssets.subText) {
        self.text = text
        self.colorAssets = colorAssets
    }

    public var body: some View {
        Text(text.localizedString)
            .foregroundStyle(colorAssets.color)
            .font(.footnote)
            .fontWeight(.regular)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
    }
}

#Preview {
    FootnoteLabel(.anyText("サンプル"))
}
