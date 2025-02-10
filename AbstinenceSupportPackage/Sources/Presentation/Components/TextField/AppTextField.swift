// Created by okazakishinya on 2025/02/10.

import SwiftUI
import Common

public struct AppTextField: View {
    let placeholder: LocalizedString
    @Binding var text: String
    let error: String?
    let keyboardType: UIKeyboardType
    @Environment(\.isEnabled) var isEnabled: Bool

    public init(placeholder: LocalizedString, text: Binding<String>, keyboardType: UIKeyboardType, error: String? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.keyboardType = keyboardType
        self.error = error
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            VStack {
                TextField("", text: $text, prompt: placeholderText)
                    .font(.body)
                    .foregroundStyle(isEnabled ? ColorAssets.baseText.color : ColorAssets.baseDisabled.color)
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .keyboardType(keyboardType)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .onTapGesture {}
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

    fileprivate var placeholderText: Text {
        Text(placeholder.localizedString)
            .foregroundStyle(ColorAssets.placeholder.color)
    }
}

#Preview {
    @Previewable @State var text = "テスト"

    VStack {
        AppTextField(placeholder: .anyText("placeholder"), text: $text, keyboardType: .default)
        AppTextField(placeholder: .anyText("placeholder"), text: $text, keyboardType: .default, error: "error")
    }
    .padding()
}
