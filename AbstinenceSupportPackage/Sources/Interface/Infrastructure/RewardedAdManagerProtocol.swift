// Created by okazakishinya on 2025/02/25.

import Foundation

public protocol RewardedAdManagerProtocol: Sendable {
    /// 広告を読み込む
    /// - Returns: 読み込みに成功したかどうか
    func loadAd() async -> Bool
    /// 広告を表示する
    /// - Parameter completionHandler: 広告表示結果
    func showAd(completionHandler: @escaping @MainActor @Sendable (_ rewardAmonut: Int?) -> Void) async
}
