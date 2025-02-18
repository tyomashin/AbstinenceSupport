// Created by okazakishinya on 2025/02/09.

import Foundation

public enum LocalizedString {

    // MARK: 共通

    case nextButton
    case closeButton
    case timeFormat

    // MARK: バリデーションエラー

    case validationErrorEmpty

    // MARK: オンボーディング

    case onboardingWelcomeTitle
    case onboardingWelcomeDetail
    case onboardingTargetTitle
    case onboardingTargetDetail
    case onboardingPenaltyTitle
    case onboardingPenaltyDetail
    case onboardingStartTitle
    case onboardingStartDetail
    case onboardingStartButtonTitle

    // MARK: 禁欲開始

    case abstinenceStartNameEntryTitle
    case abstinenceStartNameEntryDetail
    case abstinenceStartNameTextFieldTitle
    case abstinenceStartNameTextFieldPlaceholder
    case abstinenceStartDetailTextEditorTitle
    case abstinenceStartTargetDaysSelectionTitle
    case abstinenceStartTargetDaysSelectionDetail
    case abstinenceStartTargetDaysSelectionItem(days: Int)
    case abstinenceReportTimeSelectionTitle
    case abstinenceReportTimeSelectionDetail
    case abstinenceReportTimeSelectionPickerTitle
    case abstinenceReportTimeSelectionPickerCaption
    case abstinenceReportTimeSelectionAlert
    case abstinencePenaltySelectionTitle
    case abstinencePenaltySelectionDetail
    case abstinenceConfirmationTitle
    case abstinenceConfirmationDetail
    case abstinenceConfirmationNameTitle
    case abstinenceConfirmationDetailTitle
    case abstinenceConfirmationTargetDaysTitle
    case abstinenceConfirmationTargetDaysDetail(days: Int)
    case abstinenceConfirmationReportTimeTitle
    case abstinenceConfirmationPenaltyTitle
    case abstinenceConfirmationSuccessConditionTitle
    case abstinenceConfirmationSuccessConditionFirst
    case abstinenceConfirmationFailConditionTitle
    case abstinenceConfirmationFailConditionFirst
    case abstinenceConfirmationFailConditionSecond
    case abstinenceConfirmationButton

    // MARK: ペナルティ

    case penaltyFreeTitle
    case penaltyFreeDetail
    case penaltyFeeTitle(price: Int, description: String)

    // MARK: その他

    case anyText(_ text: String)

}

extension LocalizedString {
    public var localizedString: String {
        switch self {
        case .nextButton:
            String(localized: "nextButton", defaultValue: "次へ")
        case .closeButton:
            String(localized: "closeButton", defaultValue: "閉じる")
        case .timeFormat:
            String(localized: "timeFormat", defaultValue: "H 時 m 分")

        case .validationErrorEmpty:
            String(localized: "validationErrorEmpty", defaultValue: "入力してください")

        case .onboardingWelcomeTitle:
            String(localized: "onboardingWelcomeTitle", defaultValue: "禁欲サポートにようこそ")
        case .onboardingWelcomeDetail:
            String(
                localized: "onboardingWelcomeDetail",
                defaultValue:
                    """
                    このアプリでは、あなたの「やめたい」を実現するお手伝いをします。

                    ・SNS
                    ・おやつ
                    ・たばこ
                    ・お酒
                    ・ギャンブル
                    ...etc
                    """
            )
        case .onboardingTargetTitle:
            String(localized: "onboardingTargetTitle", defaultValue: "意思の弱い人のために")
        case .onboardingTargetDetail:
            String(
                localized: "onboardingTargetDetail",
                defaultValue:
                    """
                    やめる決意をしても、なかなか続かずに挫折してしまうこと、ありませんか？

                    ・次の日になったら決意が薄れてしまう...
                    ・禁欲アプリをアンインストールして何度もやり直してしまう...

                    本アプリの禁欲ルールは厳しく管理されるため、禁欲を習慣化することができます。
                    """
            )
        case .onboardingPenaltyTitle:
            String(localized: "onboardingPenaltyTitle", defaultValue: "自分にペナルティを課す")
        case .onboardingPenaltyDetail:
            String(
                localized: "onboardingPenaltyDetail",
                defaultValue:
                    """
                    このアプリでは、禁欲に失敗した時に支払うペナルティを設定できます。

                    ペナルティを支払わないと、引き続きアプリを利用することができません。
                    アプリをアンインストールしてもその情報は引き継がれます。
                    """
            )
        case .onboardingStartTitle:
            String(localized: "onboardingStartTitle", defaultValue: "禁欲を開始する")
        case .onboardingStartDetail:
            String(
                localized: "onboardingStartDetail",
                defaultValue:
                    """
                    やめたいことがあるけれど、なかなかやめられない...と悩んでいる方へ

                    このアプリを使用して、一緒に夢を実現しましょう！
                    """
            )
        case .onboardingStartButtonTitle:
            String(localized: "onboardingStartButtonTitle", defaultValue: "禁欲を開始")
        case .anyText(let text):
            text
        case .abstinenceStartNameEntryTitle:
            String(localized: "abstinenceStartNameEntryTitle", defaultValue: "禁欲を開始する")
        case .abstinenceStartNameEntryDetail:
            String(localized: "abstinenceStartNameEntryDetail", defaultValue: "あなたのやめたいことを入力してください")
        case .abstinenceStartNameTextFieldTitle:
            String(localized: "abstinenceStartNameTextFieldTitle", defaultValue: "やめること")
        case .abstinenceStartNameTextFieldPlaceholder:
            String(localized: "abstinenceStartNameTextFieldPlaceholder", defaultValue: "例）おやつ、お酒、ギャンブル")
        case .abstinenceStartDetailTextEditorTitle:
            String(localized: "abstinenceStartDetailTextEditorTitle", defaultValue: "詳細（任意）")
        case .abstinenceStartTargetDaysSelectionTitle:
            String(localized: "abstinenceStartTargetDaysSelectionTitle", defaultValue: "禁欲の目標日数")
        case .abstinenceStartTargetDaysSelectionDetail:
            String(
                localized: "abstinenceStartTargetDaysSelectionDetail",
                defaultValue:
                    """
                    禁欲を継続する日数を決めてください。

                    まずは達成可能な日数から始めてみましょう。
                    禁欲に慣れてきた方や、強い意志で禁欲する方は、長めの日数を指定しましょう。
                    """
            )
        case .abstinenceStartTargetDaysSelectionItem(let days):
            String(localized: "abstinenceStartDetailTextEditorTitle", defaultValue: "\(days) 日")
        case .abstinenceReportTimeSelectionTitle:
            String(localized: "abstinenceReportTimeSelectionTitle", defaultValue: "禁欲の報告時間を決める")
        case .abstinenceReportTimeSelectionDetail:
            String(
                localized: "abstinenceReportTimeSelectionDetail",
                defaultValue:
                    """
                    禁欲を開始すると、あなたは毎日決められた時間にアプリから「達成報告」をする必要があります。
                    """
            )
        case .abstinenceReportTimeSelectionPickerTitle:
            String(localized: "abstinenceReportTimeSelectionPickerTitle", defaultValue: "報告時間")
        case .abstinenceReportTimeSelectionPickerCaption:
            String(localized: "abstinenceReportTimeSelectionPickerCaption", defaultValue: "この時間から1時間以内にアプリを開いて「報告ボタン」をタップしてください")
        case .abstinenceReportTimeSelectionAlert:
            String(localized: "abstinenceReportTimeSelectionAlert", defaultValue: "※ 報告時間から1時間以内に報告できなければ、禁欲は失敗となります。")
        case .abstinencePenaltySelectionTitle:
            String(localized: "abstinencePenaltySelectionTitle", defaultValue: "禁欲失敗時のペナルティ")
        case .abstinencePenaltySelectionDetail:
            String(
                localized: "abstinencePenaltySelectionDetail",
                defaultValue:
                    """
                    禁欲に失敗した時のペナルティを決めてください。

                    禁欲に成功するか、禁欲を途中で中止した場合は、ペナルティを支払う必要はありません。
                    """
            )
        case .penaltyFreeTitle:
            String(localized: "penaltyFreeTitle", defaultValue: "0 円: ペナルティなし")
        case .penaltyFreeDetail:
            String(
                localized: "penaltyFreeDetail",
                defaultValue:
                    """
                    初めてアプリを利用する方にオススメです。
                    """
            )
        case let .penaltyFeeTitle(price: price, description: description):
            String(localized: "penaltyFeeTitle", defaultValue: "\(price) 円:  \(description)")
        case .abstinenceConfirmationTitle:
            String(localized: "abstinenceConfirmationTitle", defaultValue: "禁欲内容の確認")
        case .abstinenceConfirmationDetail:
            String(localized: "abstinenceConfirmationDetail", defaultValue: "以下の内容で禁欲を開始します。")
        case .abstinenceConfirmationNameTitle:
            String(localized: "abstinenceConfirmationNameTitle", defaultValue: "やめること")
        case .abstinenceConfirmationDetailTitle:
            String(localized: "abstinenceConfirmationDetailTitle", defaultValue: "詳細")
        case .abstinenceConfirmationTargetDaysTitle:
            String(localized: "abstinenceConfirmationTargetDaysTitle", defaultValue: "目標日数")
        case let .abstinenceConfirmationTargetDaysDetail(days: days):
            String(localized: "abstinenceConfirmationTargetDaysDetail", defaultValue: "\(days) 日間")
        case .abstinenceConfirmationReportTimeTitle:
            String(localized: "abstinenceConfirmationReportTimeTitle", defaultValue: "毎日の報告時間")
        case .abstinenceConfirmationPenaltyTitle:
            String(localized: "abstinenceConfirmationPenaltyTitle", defaultValue: "失敗時のペナルティ")
        case .abstinenceConfirmationSuccessConditionTitle:
            String(localized: "abstinenceConfirmationSuccessConditionTitle", defaultValue: "禁欲成功の条件")
        case .abstinenceConfirmationSuccessConditionFirst:
            String(localized: "abstinenceConfirmationSuccessConditionFirst", defaultValue: "目標日数以上に禁欲を継続できた場合")
        case .abstinenceConfirmationFailConditionTitle:
            String(localized: "abstinenceConfirmationFailConditionTitle", defaultValue: "禁欲失敗の条件")
        case .abstinenceConfirmationFailConditionFirst:
            String(localized: "abstinenceConfirmationFailConditionFirst", defaultValue: "毎日の報告時間から1時間以内に達成報告ができなかった場合")
        case .abstinenceConfirmationFailConditionSecond:
            String(localized: "abstinenceConfirmationFailConditionSecond", defaultValue: "毎日の達成報告で自ら失敗を認めた場合")
        case .abstinenceConfirmationButton:
            String(localized: "abstinenceConfirmationButton", defaultValue: "禁欲を開始する")

        }
    }
}
