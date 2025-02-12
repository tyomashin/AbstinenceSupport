// Created by okazakishinya on 2025/02/09.

import SwiftUI
import Interface

public struct RootView<ViewModel: RootViewModelProtocol>: View {

    @StateObject var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        switch viewModel.appTransitionState {
        case .onboarding:
            OnboardingView(
                viewModel: OnboardingViewModel(completionHandler: viewModel.completedOnboarding)
            )
        case .top(let abstinenceInfo):
            // TODO: トップ画面を表示
            EmptyView()
        case .abstinenceStart:
            // TODO: 禁欲開始画面を表示
            EmptyView()
        case .abstinenceFailure(let abstinenceInfo):
            // TODO: 禁欲失敗画面を表示
            EmptyView()
        case nil:
            // TODO: スプラッシュ画面を表示
            EmptyView()
        }
    }
}

#Preview {
    RootView(viewModel: .preview)
}
