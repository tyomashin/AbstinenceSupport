// Created by okazakishinya on 2025/02/18.

import Foundation
import SwiftUI
import Common
import Interface
import Entity

/// 禁欲開始画面 - 確認画面
struct AbstinenceStartConfirmationView<ViewModel: AbstinenceStartRootViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {

                VStack(alignment: .leading, spacing: 20) {
                    TitleLabel(.abstinenceConfirmationTitle)

                    HeadlineLabel(.abstinenceConfirmationDetail, colorAssets: .subText)

                    confirmationView

                    successConditionView

                    failConditionView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaPadding(.bottom, 20)

            FillButton(.abstinenceConfirmationButton, colorAssets: .baseAccent) {
                viewModel.tappedConfirmationStartButton()
            }
            .disabled(viewModel.isProcessing)
        }
        .padding(.bottom, 20)
        .safeAreaPadding(.horizontal, 16)
    }
}

// MARK: 禁欲情報の確認 View

extension AbstinenceStartConfirmationView {

    fileprivate func entryItemView(title: LocalizedString, detail: LocalizedString) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            BodyLabel(title, colorAssets: .baseText)
            BodyLabel(detail, colorAssets: .subText)
        }
    }

    fileprivate var confirmationView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {

                // やめること
                entryItemView(
                    title: .abstinenceConfirmationNameTitle,
                    detail: .anyText(viewModel.abstinenceTitle)
                )

                // 詳細
                if let detail = viewModel.detail, !detail.isEmpty {
                    entryItemView(
                        title: .abstinenceConfirmationDetailTitle,
                        detail: .anyText(detail)
                    )
                }

                // 禁欲日数
                entryItemView(
                    title: .abstinenceConfirmationTargetDaysTitle,
                    detail: .abstinenceConfirmationTargetDaysDetail(days: viewModel.targetDays)
                )

                // 報告時間
                if let time = DateUtils.dateString(from: viewModel.reportTime, dateFormat: LocalizedString.timeFormat.localizedString) {
                    entryItemView(
                        title: .abstinenceConfirmationReportTimeTitle,
                        detail: .anyText(time)
                    )
                }

                // ペナルティ
                entryItemView(
                    title: .abstinenceConfirmationPenaltyTitle,
                    detail: .anyText(viewModel.penaltyInfo.title)
                )
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .background(ColorAssets.subBackground.color)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: 成功・失敗条件に関する View

extension AbstinenceStartConfirmationView {

    fileprivate func conditionView(
        symbol: SFSymbols,
        color: ColorAssets,
        title: LocalizedString
    ) -> some View {
        HStack(alignment: .top, spacing: 8) {
            symbol.swiftUIImage
                .foregroundStyle(color.color)

            FootnoteLabel(title)
        }
    }

    fileprivate var successConditionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            BodyLabel(.abstinenceConfirmationSuccessConditionTitle, colorAssets: .baseText, weight: .bold)
            conditionView(symbol: .checkmarkCircle, color: .baseAccent, title: .abstinenceConfirmationSuccessConditionFirst)
        }
    }

    fileprivate var failConditionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            BodyLabel(.abstinenceConfirmationFailConditionTitle, colorAssets: .baseText, weight: .bold)
            conditionView(symbol: .xmarkCircle, color: .subBland, title: .abstinenceConfirmationFailConditionFirst)
            conditionView(symbol: .xmarkCircle, color: .subBland, title: .abstinenceConfirmationFailConditionSecond)
        }
    }
}

#Preview {
    VStack {
        AbstinenceStartConfirmationView(viewModel: .preview)
    }
}
