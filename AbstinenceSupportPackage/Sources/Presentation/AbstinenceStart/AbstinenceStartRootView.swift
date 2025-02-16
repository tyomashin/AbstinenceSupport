// Created by okazakishinya on 2025/02/16.

import Foundation
import SwiftUI
import Interface
import Entity

/// 禁欲開始画面のナビゲーションを管理する
struct AbstinenceStartRootView<ViewModel: AbstinenceStartRootViewModelProtocol>: View {

    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack {
                AbstinenceStartNameEntryView(viewModel: viewModel)
            }
            .navigationDestination(for: AbstinenceStartNavigationPath.self) { path in
                switch path {
                case .nameEntry:
                    EmptyView()
                case .targetDaysEntry:
                    EmptyView()
                case .scheduledReportDateEntry:
                    EmptyView()
                case .penaltiessSlection:
                    EmptyView()
                case .confirmation:
                    EmptyView()
                case .completion:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    AbstinenceStartRootView(viewModel: .preview)
}
