// Created by okazakishinya on 2025/02/18.

import Foundation
import SwiftUI
import Common
import Interface
import Entity

/// 禁欲開始画面 - 完了画面
struct AbstinenceStartCompletionView<ViewModel: AbstinenceStartCompletionViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {

                VStack(alignment: .leading, spacing: 20) {
                    TitleLabel(.abstinenceCompletionTitle)

                    HeadlineLabel(.abstinenceCompletionDetail, colorAssets: .subText)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaPadding(.bottom, 20)

            FillButton(.closeButton, colorAssets: .baseAccent) {
                viewModel.tappedCloseButton()
            }
        }
        .padding(.vertical, 20)
        .safeAreaPadding(.horizontal, 16)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    VStack {
        AbstinenceStartCompletionView(viewModel: .preview)
    }
}
