// Created by okazakishinya on 2025/02/20.

import Foundation
import Dependencies
import Interface
import Entity

enum RootViewModekKey: DependencyKey {
    static let liveValue: RootViewModel = {
        MainActor.assumeIsolated {
            RootViewModel()
        }
    }()
}

extension DependencyValues {
    public var rootViewModel: RootViewModel {
        get { self[RootViewModekKey.self] }
        set { self[RootViewModekKey.self] = newValue }
    }
}

// MARK: - 画面遷移

/// 禁欲ステータス変化に伴い、アプリの画面構成が変化した時に呼ばれる
enum NotifyChangedAppTransitionStateKey: DependencyKey {
    static let liveValue: @Sendable @MainActor (_ nextTransition: AppTransitionState?) -> Void = { nextTransition in
        @Dependency(\.rootViewModel) var rootViewModel
        rootViewModel.notifyChangedAppTransitionState(nextTransition: nextTransition)
    }
}

extension DependencyValues {
    var notifyChangedAppTransitionState: @Sendable @MainActor (_ nextTransition: AppTransitionState?) -> Void {
        get { self[NotifyChangedAppTransitionStateKey.self] }
        set { self[NotifyChangedAppTransitionStateKey.self] = newValue }
    }
}
