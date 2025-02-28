// Created by okazakishinya on 2025/02/16.

import Foundation
import SwiftUI
import Common
import Interface

/// 禁欲開始画面 - 禁欲日数選択画面
struct AbstinenceStartTargetDaysSelectionView<ViewModel: AbstinenceStartRootViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel
    @State private var selectedDays: Int
    let items: [Int] = Array(1...300)

    init(viewModel: ViewModel, targetDays: Int) {
        self.viewModel = viewModel
        self.selectedDays = targetDays
    }

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    HeadlineLabel(.abstinenceStartTargetDaysSelectionDetail, colorAssets: .subText)

                    Picker("禁欲の日数選択ピッカー", selection: $selectedDays) {
                        ForEach(items, id: \.self) { days in
                            Text(LocalizedString.abstinenceStartTargetDaysSelectionItem(days: days).localizedString)
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding(.top, 10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaPadding(.vertical, 20)
            .contentMargins(.horizontal, 16, for: .scrollContent)

            FillButton(.nextButton, colorAssets: .subBland) {
                viewModel.tappedTargetDaysNextButton(targetDays: selectedDays)
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle(LocalizedString.abstinenceStartTargetDaysSelectionTitle.localizedString)
        .padding(.bottom, 20)
    }
}

#Preview {
    VStack {
        AbstinenceStartTargetDaysSelectionView(viewModel: .preview, targetDays: 10)
    }
}
