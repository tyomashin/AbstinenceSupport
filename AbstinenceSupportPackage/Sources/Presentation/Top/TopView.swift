// Created by okazakishinya on 2025/02/19.

import Foundation
import SwiftUI
import Interface
import Common

/// トップ画面
///
/// - Note: 禁欲中と禁欲成功時の画面を出し分ける
struct TopView<ViewModel: TopViewModelProtocol>: View {

    @StateObject var viewModel: ViewModel
    @State var isPopoverDetail = false

    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            if viewModel.isCompletedInitialization {
                contentView
                    .disabled(viewModel.isProcessing)
            }
        }
        .overlay {
            // 禁欲成功時の紙吹雪アニメーション
            if viewModel.abstinenceInformation.progressStatus.isSuccess {
                AppLottieView(animation: .celebrate2, loopMode: .loop)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .allowsHitTesting(false)
            }
        }
        .alert(viewModel.alertInfo?.title ?? "", isPresented: $viewModel.isPresentedAlert, presenting: viewModel.alertInfo) { details in
            ForEach(details.buttonList) { info in
                Button(info.title, role: info.role) {
                    info.action?()
                }
            }
        } message: { details in
            if let message = details.message {
                Text(message)
            }
        }
        .task {
            await viewModel.setupIfNeeded()
        }
    }
}

// MARK: - トップ画面共通View

extension TopView {

    fileprivate var contentView: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                if viewModel.abstinenceInformation.progressStatus.isSuccess {
                    successView
                } else {
                    inProgressView
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaPadding(.horizontal, 16)
        .safeAreaPadding(.vertical, 20)
        .animation(.default, value: viewModel.abstinenceInformation.progressStatus.isSuccess)
    }

    /// 進捗情報
    fileprivate func progressView(
        progressValue: CGFloat, title: LocalizedString, detail: LocalizedString
    ) -> some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(ColorAssets.subBackground.color)

            Circle()
                .inset(by: 6)
                .trim(from: 0, to: progressValue)
                .stroke(style: .init(lineWidth: 12, lineCap: .round, lineJoin: .round))
                .foregroundStyle(ColorAssets.deepAccent.color)
                .rotationEffect(.degrees(270))

            VStack(alignment: .center, spacing: 4) {
                TitleLabel(title, colorAssets: .deepAccent)
                TitleLabel(detail, colorAssets: .baseText)
            }
        }
        .frame(width: 200)
    }

    /// 進行中・成功した禁欲情報エリア
    fileprivate var abstinenceInfoAreaView: some View {
        VStack(alignment: .center, spacing: 8) {
            TitleLabel(.anyText(viewModel.abstinenceInformation.title), colorAssets: .deepBland)

            if let detail = viewModel.abstinenceInformation.detail {
                BodyLabel(.topAbstinenceDetail, alignment: .center)
                    .popover(isPresented: $isPopoverDetail) {
                        BodyLabel(.anyText(detail))
                            .padding()
                            .presentationCompactAdaptation(.popover)
                    }
                    .onTapGesture {
                        isPopoverDetail = true
                    }
            }
        }
    }
}

// MARK: - 進行中時のView

extension TopView {
    fileprivate var inProgressView: some View {
        VStack(alignment: .center, spacing: 20) {
            progressView(
                progressValue: CGFloat(viewModel.abstinenceInformation.rateOfProgress),
                title: .topAbstinenceInprogressTitle,
                detail: .topAbstinenceInprogressDays(days: viewModel.abstinenceInformation.normalizedReportedCount)
            )
            abstinenceInfoAreaView
            reportAreaView
                .padding(.top, 20)
        }
    }

    /// 報告エリア
    fileprivate var reportAreaView: some View {
        VStack(alignment: .leading, spacing: 30) {

            // MARK: 成功報告ボタン

            VStack(alignment: .leading, spacing: 8) {
                FillButton(.topReportSuccessButtonTitle, colorAssets: .baseAccent) {
                    viewModel.tappedSuccessReportButton()
                }
                .disabled(!viewModel.isEnableReportButton)

                if let nextReportStartDateString = viewModel.abstinenceInformation.nextReportStartDateString {
                    FootnoteLabel(.topReportDetail(startDate: nextReportStartDateString))
                }
            }

            // MARK: 失敗報告ボタン

            FillButton(.topReportFailButtonTitle, colorAssets: .baseBland) {
                viewModel.tappedFailureReportButton()
            }

            // 禁欲中止に関するView
            switch viewModel.restrictiveAbortState {
            case .unrestricted:
                TextButton(.topAbortButtonTitle, colorAssets: .baseAlert) {
                    viewModel.tappedAbortButton()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            case .restricted(releaseDays: let days):
                CaptionLabel(.topAbortCondition(days: days), colorAssets: .subText, alignment: .center)
            }

        }
    }
}

// MARK: - 禁欲成功時のView

extension TopView {

    fileprivate var successView: some View {
        VStack(alignment: .center, spacing: 20) {
            progressView(
                progressValue: 1,
                title: .topAbstinenceSuccessTitle,
                detail: .topAbstinenceSuccessDays(days: viewModel.abstinenceInformation.elapsedDays)
            )
            abstinenceInfoAreaView
            startAreaView

            AppLottieView(animation: .celebrate1, loopMode: .loop)
                .frame(maxWidth: .infinity)
        }
    }

    /// 開始ボタンエリア
    fileprivate var startAreaView: some View {
        VStack(alignment: .leading, spacing: 8) {
            FillButton(.topNewStartButtonTitle, colorAssets: .baseAccent) {
                viewModel.tappedNewStartButton()
            }
        }
    }
}

// MARK: - プレビュー

#Preview {
    TopView(viewModel: .preview)
}
