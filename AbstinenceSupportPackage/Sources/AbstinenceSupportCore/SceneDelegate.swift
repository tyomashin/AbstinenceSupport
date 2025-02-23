// Created by okazakishinya on 2025/02/09.

import Foundation
import UIKit
import Dependencies
import Infrastructure

open class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    public var window: UIWindow?

    @Dependency(\.storeKitHelper) var storeKitHelper

    public final func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        Task {
            await storeKitHelper.subscriptionTransactionUpdate()
        }
    }
}
