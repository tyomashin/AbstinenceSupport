// Created by okazakishinya on 2025/02/23.

import Foundation

/// 禁欲情報の通知種別
enum AbstinenceNotifications {
    case nextReportStartDate
    case nextReportEndDate

    var notificationID: String {
        switch self {
        case .nextReportStartDate:
            "nextReportStartDate"
        case .nextReportEndDate:
            "nextReportEndDate"
        }
    }
}
