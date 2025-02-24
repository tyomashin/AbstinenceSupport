// Created by okazakishinya on 2025/02/17.

import Foundation
import SwiftUI
import Common
import Interface

/// 禁欲開始画面 - 報告時間選択画面
struct AbstinenceStartReportTimeSelectionView<ViewModel: AbstinenceStartRootViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel
    @State private var selectedReportTime: Date

    init(viewModel: ViewModel, reportTime: Date) {
        self.viewModel = viewModel
        self.selectedReportTime = reportTime
    }

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    HeadlineLabel(.abstinenceReportTimeSelectionDetail, colorAssets: .subText)

                    VStack(alignment: .leading, spacing: 8) {
                        BodyLabel(.abstinenceReportTimeSelectionPickerTitle)
                            .padding(.top, 10)

                        CaptionLabel(.abstinenceReportTimeSelectionPickerCaption)

                        DatePicker("報告時間", selection: $selectedReportTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .frame(maxWidth: .infinity)

                    }

                    HeadlineLabel(.abstinenceReportTimeSelectionAlert, colorAssets: .baseAlert)

                    noticeView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaPadding(.vertical, 20)

            FillButton(.nextButton, colorAssets: .subBland) {
                viewModel.tappedReportTimeNextButton(reportTime: selectedReportTime)
            }
        }
        .navigationTitle(LocalizedString.abstinenceReportTimeSelectionTitle.localizedString)
        .padding(.bottom, 20)
        .padding(.horizontal, 16)
    }

    fileprivate var noticeView: some View {
        VStack(alignment: .leading, spacing: 8) {
            BodyLabel(.abstinenceReportTimeSelectionNoteTitle, colorAssets: .baseText, alignment: .leading)
            FootnoteLabel(.abstinenceReportTimeSelectionNoteDetail, colorAssets: .subText, alignment: .leading)
        }
        .padding(16)
        .background(ColorAssets.subBackground.color)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    VStack {
        AbstinenceStartReportTimeSelectionView(viewModel: .preview, reportTime: Date())
    }
}
