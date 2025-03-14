// Created by okazakishinya on 2025/02/16.

import Foundation

/// 禁欲開始画面のナビゲーション定義
public enum AbstinenceStartNavigationPath: Hashable {
    case nameEntry
    case targetDaysEntry
    case scheduledReportDateEntry
    case confirmation
    case completion(info: AbstinenceInformation)
}
