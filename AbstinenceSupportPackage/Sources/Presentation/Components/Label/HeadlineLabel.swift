// Created by okazakishinya on 2025/02/10.

import SwiftUI
import Common

public struct HeadlineLabel: View {

    let text: LocalizedString
    let colorAssets: ColorAssets
    let alignment: LabelAlignment

    public init(
        _ text: LocalizedString,
        colorAssets: ColorAssets = ColorAssets.baseText,
        alignment: LabelAlignment = .leading
    ) {
        self.text = text
        self.colorAssets = colorAssets
        self.alignment = alignment
    }

    public var body: some View {
        Text(text.localizedString)
            .foregroundStyle(colorAssets.color)
            .font(.headline)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: alignment.alignment)
            .multilineTextAlignment(alignment.textAlignment)
            .lineSpacing(4)
    }
}

#Preview {
    HeadlineLabel(.anyText("サンプル"))
}
