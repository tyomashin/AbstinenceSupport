// Created by okazakishinya on 2025/02/17.

import Foundation
import SwiftUI
import Common

struct SelectablePenaltyCard: View {

    @Binding var isSelected: Bool
    let title: String
    let detail: String
    let colorAssets: ColorAssets
    let cornerRadius: CGFloat = 8
    let lineWidth: CGFloat = 4

    init(
        isSelected: Binding<Bool>,
        title: String,
        detail: String,
        colorAssets: ColorAssets = .subAccent
    ) {
        self._isSelected = isSelected
        self.title = title
        self.detail = detail
        self.colorAssets = colorAssets
    }

    var body: some View {
        Button(
            action: {
                isSelected.toggle()
            },
            label: {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(title)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundStyle(ColorAssets.baseText.color)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)

                        Text(detail)
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundStyle(ColorAssets.baseText.color)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }

                    if isSelected {
                        SFSymbols.checkmarkCircleFill.swiftUIImage
                            .foregroundStyle(ColorAssets.baseAccent.color)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(ColorAssets.baseSelectableCard.color)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .inset(by: lineWidth / 2)
                        .stroke(isSelected ? colorAssets.color : .clear, lineWidth: lineWidth)
                )
            }
        )
        .background(ColorAssets.baseBackground.color)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .animation(.none, value: isSelected)
    }
}

#Preview {
    VStack {
        SelectablePenaltyCard(
            isSelected: .constant(true),
            title: "タイトル",
            detail: "詳細"
        )
        SelectablePenaltyCard(
            isSelected: .constant(false),
            title: "タイトル",
            detail: "詳細"
        )
    }
    .padding()
}
