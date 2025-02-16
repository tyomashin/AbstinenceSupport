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
                    TitleLabel(.abstinenceReportTimeSelectionTitle)

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
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            FillButton(.nextButton, colorAssets: .baseAccent) {
                viewModel.tappedReportTimeNextButton(reportTime: selectedReportTime)
            }
        }
        .padding(.bottom, 20)
        .padding(.horizontal, 16)
    }
}

#Preview {
    VStack {
        AbstinenceStartReportTimeSelectionView(viewModel: .preview, reportTime: Date())
    }
}
