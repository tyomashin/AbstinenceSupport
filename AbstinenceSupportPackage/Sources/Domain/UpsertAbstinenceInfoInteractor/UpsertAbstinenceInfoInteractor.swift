// Created by okazakishinya on 2025/02/12.

import Foundation
import Interface
import Entity
import Dependencies
import Infrastructure

struct UpsertAbstinenceInfoInteractor: UpsertAbstinenceInfoUseCase {

    @Dependency(\.keyChainHelper) var keyChainHelper
    @Dependency(\.widgetKitHelper) var widgetKitHelper

    func execute(_ info: AbstinenceInformation) async {
        keyChainHelper.save(abstinenceInformation: info)
        // ウィジェットのタイムラインを更新する
        await widgetKitHelper.reloadAllTimelines()
    }
}
