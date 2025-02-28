// Created by okazakishinya on 2025/02/09.

import Foundation
import UIKit
import FirebaseCore
import FirebaseAnalytics
@preconcurrency import GoogleMobileAds
import Common
import Infrastructure

public final class AppDelegate: UIResponder, UIApplicationDelegate {

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupFirebase()
        return true
    }

    public final func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self
        return config
    }

}

extension AppDelegate {
    private func setupFirebase() {
        FirebaseApp.configure()
        Analytics.setAnalyticsCollectionEnabled(true)
        Analytics.logEvent(
            "AppLaunch",
            parameters: ["AppName": Constants.appName, "AppVersion": Constants.appVersion, "BuildVersion": Constants.buildVersion]
        )
        setupADs()
    }

    fileprivate func setupADs() {
        Task {
            await MobileAds.shared.start()
            #if DEBUG
                AdSettings.currentAdUnitID = .makeTestInscance()
            #else
                AdSettings.currentAdUnitID = .init(rewardID: SecureInfo.AD.rewardID)
            #endif
        }
    }
}
