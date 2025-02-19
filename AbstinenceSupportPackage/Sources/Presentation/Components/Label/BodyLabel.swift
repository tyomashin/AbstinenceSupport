// Created by okazakishinya on 2025/02/10.

import SwiftUI
import Common

public struct BodyLabel: View {

    let text: LocalizedString
    let colorAssets: ColorAssets
    let weight: Font.Weight
    let alignment: LabelAlignment

    public init(
        _ text: LocalizedString,
        colorAssets: ColorAssets = ColorAssets.subText,
        weight: Font.Weight = .regular,
        alignment: LabelAlignment = .leading
    ) {
        self.text = text
        self.colorAssets = colorAssets
        self.weight = weight
        self.alignment = alignment
    }

    public var body: some View {
        Text(text.localizedString)
            .foregroundStyle(colorAssets.color)
            .font(.body)
            .fontWeight(weight)
            .frame(maxWidth: .infinity, alignment: alignment.alignment)
            .multilineTextAlignment(alignment.textAlignment)
    }
}

#Preview {
    BodyLabel(.anyText("サンプル"))
}
