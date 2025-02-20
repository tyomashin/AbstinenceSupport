// Created by okazakishinya on 2025/02/09.

import SwiftUI
import Dependencies
import AbstinenceSupportCore
import Presentation

@main
struct AbstinenceSupportApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Dependency(\.rootViewModel) var rootViewModel
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: rootViewModel)
        }
    }
}
