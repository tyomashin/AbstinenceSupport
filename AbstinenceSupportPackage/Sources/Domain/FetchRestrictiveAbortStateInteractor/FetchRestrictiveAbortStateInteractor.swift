// Created by okazakishinya on 2025/02/12.

import Foundation
import Interface
import Entity
import Dependencies
import Infrastructure
import Common

struct FetchRestrictiveAbortStateInteractor: FetchRestrictiveAbortStateUseCase {

    @Dependency(\.keyChainHelper) var keyChainHelper

    func execute(with currentDate: Date) async -> RestrictiveAbortState {
        guard let currentAbortDate: Date = keyChainHelper.readAbortDate() else {
            return .unrestricted
        }
        // 前回禁欲を中止してから 30 日経過していない場合は禁欲の中止ができない
        let days = DateUtils.daysBetween(from: currentAbortDate, to: currentDate)
        if days < 30 {
            return .restricted(releaseDays: 30 - days)
        } else {
            return .unrestricted
        }
    }
}
