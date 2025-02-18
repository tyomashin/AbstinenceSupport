// Created by okazakishinya on 2025/02/09.

import SwiftUI
import Interface

public struct RootView<ViewModel: RootViewModelProtocol>: View {

    @StateObject var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        ZStack {
            switch viewModel.appTransitionState {
            case .onboarding:
                OnboardingView(
                    viewModel: OnboardingViewModel(completionHandler: viewModel.completedOnboarding)
                )
                .transition(.opacity)
            case .top(let abstinenceInfo):
                // TODO: トップ画面を表示
                EmptyView()
            case .abstinenceStart:
                AbstinenceStartRootView(
                    viewModel: AbstinenceStartRootViewModel(completionHandler: viewModel.completedAbstinenceStart)
                )
                .transition(.opacity)
            case .abstinenceFailure(let abstinenceInfo):
                // TODO: 禁欲失敗画面を表示
                EmptyView()
            case nil:
                // TODO: スプラッシュ画面を表示
                EmptyView()
            }
        }
        .task {
            await viewModel.startupSequenceIfNeeded()
        }
        .animation(.default, value: viewModel.appTransitionState)
    }
}

#Preview {
    RootView(viewModel: .preview)
}
