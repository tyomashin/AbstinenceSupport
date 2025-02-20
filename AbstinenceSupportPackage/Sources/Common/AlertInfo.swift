// Created by okazakishinya on 2025/02/20.

import Foundation
import SwiftUI

public struct AlertInfo {
    public let title: String
    public let message: String?
    public let buttonList: [AlertButtonInfo]

    public init(title: String, message: String?, buttonList: [AlertButtonInfo]) {
        self.title = title
        self.message = message
        self.buttonList = buttonList
    }
}

public struct AlertButtonInfo: Identifiable {
    public let id = UUID()
    public let title: String
    public let role: ButtonRole?
    public let action: (() -> Void)?

    public init(title: String, role: ButtonRole?, action: (() -> Void)?) {
        self.title = title
        self.role = role
        self.action = action
    }
}
