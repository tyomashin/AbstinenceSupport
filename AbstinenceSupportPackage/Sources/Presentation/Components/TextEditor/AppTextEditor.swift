// Created by okazakishinya on 2025/02/10.

import Foundation
import SwiftUI
import Common

public struct AppTextEditor: View {

    let placeholder: LocalizedString?
    @Binding var text: String
    let error: String?
    let keyboardType: UIKeyboardType
    @Environment(\.isEnabled) var isEnabled: Bool
    let height: CGFloat = 150

    public init(placeholder: LocalizedString? = nil, text: Binding<String>, keyboardType: UIKeyboardType, error: String? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.keyboardType = keyboardType
        self.error = error
    }

    public var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .font(.body)
                    .frame(height: height)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 11)
                    .padding(.vertical, 4)
                    .keyboardType(keyboardType)
                    .foregroundStyle(isEnabled ? ColorAssets.baseText.color : ColorAssets.baseDisabled.color)
                    .scrollContentBackground(.hidden)
                    .background(ColorAssets.subBackground.color)
                    // 入力エリアタップでキーボードが閉じないようにジェスチャーを追加
                    .onTapGesture {}

                // プレースホルダー
                if text.isEmpty, let placeholder {
                    Text(placeholder.localizedString)
                        .font(.body)
                        .foregroundColor(ColorAssets.placeholder.color)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .allowsHitTesting(false)
                }
            }
            .background(ColorAssets.subBackground.color)
            .clipShape(RoundedRectangle(cornerRadius: 4))

            if let error {
                Text(error)
                    .font(.footnote)
                    .foregroundStyle(ColorAssets.baseAlert.color)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

#Preview {
    @Previewable @State var text = "テスト"

    VStack(spacing: 20) {
        AppTextEditor(placeholder: .anyText("placeholder"), text: $text, keyboardType: .default)
        AppTextEditor(placeholder: .anyText("placeholder"), text: $text, keyboardType: .default, error: "error")
    }
    .padding()
}
