// Created by okazakishinya on 2025/02/14.

import Foundation
import Dependencies
import Interface
import Entity
import Infrastructure

struct StartupSequenceInteractor: StartupSequenceUseCase {

    @Dependency(\.checkAppTransitionStateInteractor) var checkAppTransitionStateInteractor
    @Dependency(\.fetchAbstinenceInfoInteractor) var fetchAbstinenceInfoInteractor
    @Dependency(\.upsertAbstinenceInfoInteractor) var upsertAbstinenceInfoInteractor
    @Dependency(\.userDefaultsHelper) var userDefaultsHelper

    func execute(currentDate: Date) async -> AppTransitionState {

        // 禁欲情報が存在すれば、ステータスを最新化して保存する
        if var info = await fetchAbstinenceInfoInteractor.execute() {
            info.updateProgressStatus(currentDate: currentDate)
            await upsertAbstinenceInfoInteractor.execute(info)
        }

        // 現在の禁欲情報に基づいて、アプリで初期表示する画面を取得
        let transitionState = await checkAppTransitionStateInteractor.execute()
        // 初回起動フラグをONにする
        await userDefaultsHelper.setIsFirstLaunch(false)

        return transitionState
    }
}
