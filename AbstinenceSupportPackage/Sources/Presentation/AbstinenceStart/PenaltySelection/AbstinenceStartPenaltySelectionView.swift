// Created by okazakishinya on 2025/02/17.

import Foundation
import SwiftUI
import Common
import Interface
import Entity

/// 禁欲開始画面 - ペナルティ選択画面
struct AbstinenceStartPenaltySelectionView<ViewModel: AbstinenceStartRootViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel
    @State private var selectedPenalty: PenaltyInfo
    @State private var allPenalties: [PenaltyInfo] = [.freePenaltyInfo()]

    init(viewModel: ViewModel, selectedPenalty: PenaltyInfo) {
        self.viewModel = viewModel
        self.selectedPenalty = selectedPenalty
    }

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    TitleLabel(.abstinencePenaltySelectionTitle)

                    HeadlineLabel(.abstinencePenaltySelectionDetail, colorAssets: .subText)

                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(allPenalties, id: \.self) { penalty in
                            SelectablePenaltyCard(
                                isSelected: .init(
                                    get: {
                                        selectedPenalty == penalty
                                    },
                                    set: { isSelected in
                                        if isSelected {
                                            selectedPenalty = penalty
                                        }
                                    }
                                ),
                                title: penalty.title,
                                detail: penalty.detail
                            )
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaPadding(.bottom, 20)

            FillButton(.nextButton, colorAssets: .subBland) {
                viewModel.tappedPenaltyNextButton(penaltyInfo: selectedPenalty)
            }
        }
        .padding(.bottom, 20)
        .safeAreaPadding(.horizontal, 16)
        .task {
            self.allPenalties = await viewModel.fetchAllPenalties()
        }
    }
}

#Preview {
    VStack {
        AbstinenceStartPenaltySelectionView(viewModel: .preview, selectedPenalty: .freePenaltyInfo())
    }
}
