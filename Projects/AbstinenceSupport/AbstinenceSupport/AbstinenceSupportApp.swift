// Created by okazakishinya on 2025/02/09.

import SwiftUI
import AbstinenceSupportCore
import Presentation

@main
struct AbstinenceSupportApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootView(viewModel: RootViewModel())
        }
    }
}
