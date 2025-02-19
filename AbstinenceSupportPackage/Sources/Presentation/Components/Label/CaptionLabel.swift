// Created by okazakishinya on 2025/02/10.

import SwiftUI
import Common

public struct CaptionLabel: View {

    let text: LocalizedString
    let colorAssets: ColorAssets
    let alignment: LabelAlignment

    public init(
        _ text: LocalizedString,
        colorAssets: ColorAssets = ColorAssets.subText,
        alignment: LabelAlignment = .leading
    ) {
        self.text = text
        self.colorAssets = colorAssets
        self.alignment = alignment
    }

    public var body: some View {
        Text(text.localizedString)
            .foregroundStyle(colorAssets.color)
            .font(.caption)
            .fontWeight(.regular)
            .frame(maxWidth: .infinity, alignment: alignment.alignment)
            .multilineTextAlignment(alignment.textAlignment)
    }
}

#Preview {
    CaptionLabel(.anyText("サンプル"))
}
