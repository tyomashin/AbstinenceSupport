// Created by okazakishinya on 2025/02/09.

import Foundation

public enum LocalizedString {
    case onboardingWelcomeTitle
    case onboardingWelcomeDetail
    case onboardingTargetTitle
    case onboardingTargetDetail
    case onboardingPenaltyTitle
    case onboardingPenaltyDetail
    case onboardingStartTitle
    case onboardingStartDetail
    case onbordingNextButtonTitle
    case onbordingStartButtonTitle
    case anyText(_ text: String)
}

extension LocalizedString {
    public var localizedString: String {
        switch self {
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
        case .onbordingNextButtonTitle:
            String(localized: "onbordingNextButtonTitle", defaultValue: "次へ")
        case .onbordingStartButtonTitle:
            String(localized: "onbordingStartButtonTitle", defaultValue: "禁欲を開始")
        case .anyText(let text):
            text
        }
    }
}
