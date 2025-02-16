// Created by okazakishinya on 2025/02/09.

import Foundation

public enum LocalizedString {

    // MARK: 共通

    case nextButton
    case closeButton

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
        }
    }
}
