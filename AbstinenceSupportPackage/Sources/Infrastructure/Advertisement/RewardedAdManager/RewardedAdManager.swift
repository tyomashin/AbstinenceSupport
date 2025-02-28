// Created by okazakishinya on 2025/02/25.

import Foundation
@preconcurrency import GoogleMobileAds
import Interface

/// リワード広告を表示する
///
/// 参考：https://developers.google.com/admob/ios/rewarded?hl=ja#swiftui
@MainActor class RewardedAdManager: NSObject, RewardedAdManagerProtocol {
    /// リワード広告視聴後に獲得できる報酬
    private var rewardAmonut: Int?
    /// 使い切りの広告オブジェクト
    private var rewardedAd: RewardedAd?

    private var completionHandler: (@MainActor @Sendable (_ rewardAmonut: Int?) -> Void)?

    func loadAd() async -> Bool {
        do {
            rewardedAd = try await RewardedAd.load(
                with: AdSettings.currentAdUnitID.rewardID,
                request: Request()
            )
            rewardedAd?.fullScreenContentDelegate = self
            return true
        } catch {
            print("Failed to load rewarded ad with error: \(error.localizedDescription)")
            return false
        }
    }

    func showAd(completionHandler: @escaping @MainActor @Sendable (_ rewardAmonut: Int?) -> Void) async {
        guard let rewardedAd = rewardedAd else {
            print("Ad wasn't ready.")
            completionHandler(nil)
            return
        }
        rewardAmonut = nil
        self.completionHandler = completionHandler

        rewardedAd.present(from: nil) { [weak self] in
            guard let self else { return }
            let reward = rewardedAd.adReward
            self.rewardAmonut = reward.amount.intValue
        }
    }
}

extension RewardedAdManager: FullScreenContentDelegate {
    func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }

    func adDidRecordClick(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }

    func ad(
        _ ad: FullScreenPresentingAd,
        didFailToPresentFullScreenContentWithError error: Error
    ) {
        print("\(#function) called")
        completionHandler?(nil)
        completionHandler = nil
    }

    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }

    func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }

    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
        completionHandler?(1)
        completionHandler = nil
    }
}
