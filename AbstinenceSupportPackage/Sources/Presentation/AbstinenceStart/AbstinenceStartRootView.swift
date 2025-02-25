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
            AbstinenceStartNameEntryView(viewModel: viewModel)
                .navigationBarTitleDisplayMode(.large)
                // NOTE: 以下の設定をすると戻るボタンの文言を非表示にすることができる。
                // しかし、次画面に遷移する際に戻るアイコンの位置が一瞬下に移動して不正になる事象があり、
                // おそらくSwiftUIのバグだと思われるので今回は使用しない
                // .toolbarRole(.editor)
                .toolbarRole(.automatic)
                .navigationDestination(for: AbstinenceStartNavigationPath.self) { path in
                    switch path {
                    case .nameEntry:
                        EmptyView()
                    case .targetDaysEntry:
                        AbstinenceStartTargetDaysSelectionView(viewModel: viewModel, targetDays: viewModel.targetDays)
                    case .scheduledReportDateEntry:
                        AbstinenceStartReportTimeSelectionView(viewModel: viewModel, reportTime: viewModel.reportTime)
                    case .confirmation:
                        AbstinenceStartConfirmationView(viewModel: viewModel)
                    case .completion(let info):
                        AbstinenceStartCompletionView(
                            viewModel: AbstinenceStartCompletionViewModel(
                                abstinenceInformation: info,
                                completionHandler: viewModel.completionHandler
                            )
                        )
                    }
                }
        }
    }
}

#Preview {
    AbstinenceStartRootView(viewModel: .preview)
}
