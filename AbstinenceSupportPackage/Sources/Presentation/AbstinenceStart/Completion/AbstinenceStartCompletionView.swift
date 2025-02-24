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
            VStack(alignment: .leading, spacing: 0) {

                HeadlineLabel(.abstinenceCompletionDetail, colorAssets: .subText)

                Spacer()

                AppLottieView(animation: .abstinenceStart)

                Spacer()
                Spacer()
            }

            FillButton(.closeButton, colorAssets: .subBland) {
                viewModel.tappedCloseButton()
            }
        }
        .safeAreaPadding(.vertical, 20)
        .safeAreaPadding(.horizontal, 16)
        .navigationBarBackButtonHidden()
        .navigationTitle(LocalizedString.abstinenceCompletionTitle.localizedString)
    }
}

#Preview {
    VStack {
        AbstinenceStartCompletionView(viewModel: .preview)
    }
}
