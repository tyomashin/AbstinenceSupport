// Created by okazakishinya on 2025/02/20.

import Foundation
import Dependencies
import Interface

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
    static let liveValue: @Sendable @MainActor () -> Void = {
        @Dependency(\.rootViewModel) var rootViewModel
        rootViewModel.notifyChangedAppTransitionState()
    }
}

extension DependencyValues {
    var notifyChangedAppTransitionState: @Sendable @MainActor () -> Void {
        get { self[NotifyChangedAppTransitionStateKey.self] }
        set { self[NotifyChangedAppTransitionStateKey.self] = newValue }
    }
}
