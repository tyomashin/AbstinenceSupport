// Created by okazakishinya on 2025/02/13.

import Foundation
import Dependencies
import Interface
import Entity
import Infrastructure

struct CheckAppTransitionStateInteractor: CheckAppTransitionStateUseCase {

    @Dependency(\.fetchAbstinenceInfoInteractor) var fetchAbstinenceInfoInteractor
    @Dependency(\.userDefaultsHelper) var userDefaultsHelper

    func execute() async -> AppTransitionState {
        // 禁欲情報がない場合、初回起動時の場合はオンボーディングへ、それ以外は禁欲開始画面へ
        guard let abstinenceInformation = await fetchAbstinenceInfoInteractor.execute() else {
            if await userDefaultsHelper.getIsFirstLaunch() {
                return .onboarding
            } else {
                return .abstinenceStart
            }
        }
        // 禁欲の進捗状況に応じて遷移先を制御
        switch abstinenceInformation.progressStatus {
        case .inProgress, .success:
            return .top(abstinenceInfo: abstinenceInformation)
        case .penaltyUnpaidForFailure:
            return .abstinenceFailure(abstinenceInfo: abstinenceInformation)
        case .penaltyPaidForFailure:
            return .abstinenceStart
        }
    }
}
