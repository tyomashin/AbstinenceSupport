// Created by okazakishinya on 2025/02/09.

import Foundation

public enum LocalizedString {

    // MARK: 共通

    case okButton
    case nextButton
    case closeButton
    case cancelButton
    case timeFormat
    case reportDateFormat

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
    case abstinenceCompletionTitle
    case abstinenceCompletionDetail

    // MARK: ペナルティ

    case penaltyFreeTitle
    case penaltyFreeDetail
    case penaltyFeeTitle(price: Int, description: String)

    // MARK: トップ

    case topAbstinenceDetail
    case topAbstinenceInprogressTitle
    case topAbstinenceInprogressDays(days: Int)
    case topAbstinenceSuccessTitle
    case topAbstinenceSuccessDays(days: Int)
    case topReportSuccessButtonTitle
    case topReportFailButtonTitle
    case topReportFailAlertTitle
    case topReportFailAlertDetail
    case topReportFailAlertOKButton
    case topAbortButtonTitle
    case topAbortAlertTitle
    case topAbortAlertDetail
    case topAbortCondition(days: Int)
    case topNewStartButtonTitle
    case topReportDetail(startDate: String)

    // MARK: 禁欲失敗

    case failureTitle
    case failureDetail
    case failurePenaltyTitle
    case failurePenaltyNotice
    case failurePayPenaltyButtonTitle
    case failurePayCompletionAlertTitle
    case failurePayCompletionAlertDetail
    case failurePayFailedAlertTitle
    case failurePayFailedAlertDetail

    // MARK: ウィジェット

    case widgetTitle
    case widgetDescription
    case widgetEmptyTitle
    case widgetScheduledReportDateForSmall(startDate: String)
    case widgetScheduledReportDateForNormal(startDate: String)
    case widgetProgressSuccessTitle
    case widgetProgressInProgressTitle
    case widgetProgressFailureTitle
    case widgetContentPaidTitle
    case widgetInprogressDays(days: Int)

    // MARK: その他

    case anyText(_ text: String)

}

extension LocalizedString {
    public var localizedString: String {
        switch self {
        case .okButton:
            String(localized: "okButton", defaultValue: "OK")
        case .nextButton:
            String(localized: "nextButton", defaultValue: "次へ")
        case .closeButton:
            String(localized: "closeButton", defaultValue: "閉じる")
        case .cancelButton:
            String(localized: "cancelButton", defaultValue: "キャンセル")
        case .timeFormat:
            String(localized: "timeFormat", defaultValue: "H 時 mm 分")
        case .reportDateFormat:
            String(localized: "reportDateFormat", defaultValue: "M月d日 H時mm分")

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
        case .abstinenceCompletionTitle:
            String(localized: "abstinenceCompletionTitle", defaultValue: "禁欲を開始しました")
        case .abstinenceCompletionDetail:
            String(localized: "abstinenceCompletionDetail", defaultValue: "目標に向かって頑張りましょう！")
        case .topAbstinenceDetail:
            String(localized: "topAbstinenceDetail", defaultValue: "詳細")
        case .topAbstinenceInprogressTitle:
            String(localized: "topAbstinenceInprogressTitle", defaultValue: "禁欲 継続中")
        case .topAbstinenceInprogressDays(let days):
            String(localized: "topAbstinenceInprogressDays", defaultValue: "\(days) 日間")
        case .topAbstinenceSuccessTitle:
            String(localized: "topAbstinenceSuccessTitle", defaultValue: "禁欲 成功🎉")
        case .topAbstinenceSuccessDays(let days):
            String(localized: "topAbstinenceSuccessDays", defaultValue: "\(days) 日")
        case .topReportSuccessButtonTitle:
            String(localized: "topReportSuccessButtonTitle", defaultValue: "本日の禁欲達成報告")
        case .topReportFailButtonTitle:
            String(localized: "topReportFailButtonTitle", defaultValue: "禁欲の失敗報告")
        case .topReportFailAlertTitle:
            String(localized: "topReportFailAlertTitle", defaultValue: "禁欲の失敗")
        case .topReportFailAlertDetail:
            String(localized: "topReportFailAlertDetail", defaultValue: "禁欲に失敗したことを自己申告しますか？事前に設定したペナルティを支払う必要があります。")
        case .topReportFailAlertOKButton:
            String(localized: "topReportFailAlertOKButton", defaultValue: "失敗を報告する")
        case .topAbortButtonTitle:
            String(localized: "topAbortButtonTitle", defaultValue: "禁欲を中止する")
        case .topAbortAlertTitle:
            String(localized: "topAbortAlertTitle", defaultValue: "禁欲の中止")
        case .topAbortAlertDetail:
            String(localized: "topAbortAlertDetail", defaultValue: "現在進行中の禁欲を中止して、新しい禁欲を開始しますか？一度禁欲を中止すると、しばらくの期間は禁欲を中止できなくなります。")
        case .topAbortCondition(let days):
            String(localized: "topAbortCondition", defaultValue: "\(days) 日経過後に禁欲を中止できます")
        case .topNewStartButtonTitle:
            String(localized: "topNewStartButtonTitle", defaultValue: "新しい禁欲を開始する")
        case .topReportDetail(let startDate):
            String(localized: "topReportDetail", defaultValue: "\(startDate) から1時間以内に報告してください。")
        case .failureTitle:
            String(localized: "failureTitle", defaultValue: "禁欲に失敗しました")
        case .failureDetail:
            String(
                localized: "failureDetail",
                defaultValue:
                    """
                    ⚠️ 初心を大切に
                    禁欲の決意を毎日思い出して、禁欲を習慣にすることが大切です。
                    気持ちの整理ができたら、再度チャレンジしましょう。
                    """
            )
        case .failurePenaltyTitle:
            String(localized: "failurePenaltyTitle", defaultValue: "あなたが設定したペナルティ")
        case .failurePenaltyNotice:
            String(localized: "failurePenaltyNotice", defaultValue: "アプリの利用を継続するにはペナルティを支払う必要があります。")
        case .failurePayPenaltyButtonTitle:
            String(localized: "failurePayPenaltyButtonTitle", defaultValue: "ペナルティを支払う")
        case .failurePayCompletionAlertTitle:
            String(localized: "failurePayCompletionAlertTitle", defaultValue: "支払い完了")
        case .failurePayCompletionAlertDetail:
            String(localized: "failurePayCompletionAlertDetail", defaultValue: "ペナルティの支払いが完了しました。新しい禁欲を開始できます。")
        case .failurePayFailedAlertTitle:
            String(localized: "failurePayFailedAlertTitle", defaultValue: "エラー")
        case .failurePayFailedAlertDetail:
            String(localized: "failurePayFailedAlertDetail", defaultValue: "ペナルティの支払いが完了できませんでした。")
        case .widgetTitle:
            String(localized: "widgetTitle", defaultValue: "禁欲サポート")
        case .widgetDescription:
            String(localized: "widgetDescription", defaultValue: "禁欲の進行状況が確認できます")
        case .widgetEmptyTitle:
            String(localized: "widgetEmptyTitle", defaultValue: "禁欲情報が読み取れませんでした。アプリを起動してください。")
        case .widgetScheduledReportDateForSmall(let startDate):
            String(localized: "widgetScheduledReportDateForSmall", defaultValue: "\(startDate)〜")
        case .widgetScheduledReportDateForNormal(let startDate):
            String(localized: "widgetScheduledReportDateForNormal", defaultValue: "報告予定日時：\n\(startDate)〜")
        case .widgetProgressSuccessTitle:
            String(localized: "widgetProgressSuccessTitle", defaultValue: "禁欲成功🎉")
        case .widgetProgressInProgressTitle:
            String(localized: "widgetProgressInProgressTitle", defaultValue: "禁欲継続中")
        case .widgetProgressFailureTitle:
            String(localized: "widgetProgressFailureTitle", defaultValue: "禁欲 失敗")
        case .widgetContentPaidTitle:
            String(
                localized: "widgetContentPaidTitle",
                defaultValue:
                    """
                    新しい禁欲を開始できます。
                    """
            )
        case .widgetInprogressDays(let days):
            String(localized: "widgetInprogressDays", defaultValue: "\(days) 日間")
        }
    }
}
