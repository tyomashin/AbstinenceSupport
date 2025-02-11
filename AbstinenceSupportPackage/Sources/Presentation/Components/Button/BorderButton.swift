// Created by okazakishinya on 2025/02/11.

import SwiftUI
import Common

public struct BorderButton: View {

    @Environment(\.isEnabled) var isEnabled: Bool
    let title: LocalizedString
    let colorAssets: ColorAssets
    let tapAction: () -> Void
    let cornerRadius: CGFloat = 8
    let lineWidth: CGFloat = 4

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
                .foregroundStyle(isEnabled ? colorAssets.color : ColorAssets.baseDisabled.color)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .inset(by: lineWidth / 2)
                        .stroke(isEnabled ? colorAssets.color : ColorAssets.baseDisabled.color, lineWidth: lineWidth)
                )
        }
        .background(.clear)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

#Preview {
    VStack(spacing: 4) {
        BorderButton(.anyText("サンプル"), tapAction: {})
        BorderButton(.anyText("サンプル"), colorAssets: ColorAssets.baseAccent, tapAction: {})
        BorderButton(.anyText("サンプル"), tapAction: {})
            .environment(\.isEnabled, false)
        BorderButton(.anyText("サンプル"), colorAssets: ColorAssets.baseAccent, tapAction: {})
            .environment(\.isEnabled, false)
    }
    .padding()
    .background(.black)
}
