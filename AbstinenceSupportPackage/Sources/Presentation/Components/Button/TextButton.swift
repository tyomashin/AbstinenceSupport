// Created by okazakishinya on 2025/02/10.

import SwiftUI
import Common

public struct TextButton: View {
    @Environment(\.isEnabled) var isEnabled: Bool
    let text: LocalizedString
    let colorAssets: ColorAssets
    let tapAction: () -> Void

    public init(_ text: LocalizedString, colorAssets: ColorAssets = .deepAccent, tapAction: @escaping () -> Void) {
        self.text = text
        self.colorAssets = colorAssets
        self.tapAction = tapAction
    }

    public var body: some View {
        Button(action: tapAction) {
            Text(text.localizedString)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundStyle(isEnabled ? colorAssets.color : ColorAssets.baseDisabled.color)
        }
    }
}

#Preview {
    VStack {
        TextButton(.anyText("サンプル"), tapAction: {})
    }
    .padding()
}
