// Created by okazakishinya on 2025/02/16.

import SwiftUI
import Common
import Interface

/// 禁欲開始画面 - 名称入力画面
struct AbstinenceStartNameEntryView<ViewModel: AbstinenceStartRootViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel

    @State var nameInputForm: AbstinenceNameInputForm = .init(text: "")
    @State var detail: String = ""
    @FocusState var focusState: Bool

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    TitleLabel(.abstinenceStartNameEntryTitle)

                    HeadlineLabel(.abstinenceStartNameEntryDetail)

                    VStack(alignment: .leading, spacing: 8) {
                        BodyLabel(.abstinenceStartNameTextFieldTitle)
                            .padding(.top, 10)

                        AppTextField(
                            placeholder: .abstinenceStartNameTextFieldPlaceholder,
                            text: $nameInputForm.text,
                            keyboardType: .default,
                            error: nameInputForm.error
                        )
                        .focused($focusState)

                        BodyLabel(.abstinenceStartDetailTextEditorTitle)

                        AppTextEditor(
                            text: $detail,
                            keyboardType: .default
                        )
                        .focused($focusState)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            FillButton(.nextButton, colorAssets: .baseAccent) {
                nameInputForm.validate()
                guard !nameInputForm.isError else { return }

                viewModel.tappedNameEntryNextButton(title: nameInputForm.text, detail: detail)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .onTapGesture {
            focusState = false
        }
        .onChange(of: nameInputForm.text) {
            nameInputForm.error = nil
        }
    }
}

#Preview {
    VStack {
        AbstinenceStartNameEntryView(viewModel: .preview)
    }
}
