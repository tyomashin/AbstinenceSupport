// Created by okazakishinya on 2025/02/22.

import SwiftUI
import Interface
import Common

struct FailureView<ViewModel: FailureViewModelProtocol>: View {

    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {

                // MARK: 禁欲失敗の説明

                VStack(alignment: .leading, spacing: 10) {

                    TitleLabel(.failureTitle, colorAssets: .baseBland)

                    AppLottieView(animation: .failed, loopMode: .playOnce)
                        .frame(maxHeight: 200)

                    HeadlineLabel(.failureDetail, colorAssets: .baseText, alignment: .leading)
                }

                VStack(alignment: .leading, spacing: 8) {

                    FillButton(.failureStartButtonTitle, colorAssets: .subBland) {
                        viewModel.payPenalty()
                    }
                    .disabled(viewModel.isPaying)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaPadding(.horizontal, 16)
        .safeAreaPadding(.vertical, 20)
    }
}

#Preview("free") {
    FailureView(viewModel: .previewFreePenalty)
}

#Preview("penalty") {
    FailureView(viewModel: .previewPenalty)
}
