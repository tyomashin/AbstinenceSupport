// Created by okazakishinya on 2025/02/22.

import Foundation
import Entity
import Common

@MainActor
public protocol FailureViewModelProtocol: ObservableObject {

    /// 禁欲情報
    var abstinenceInformation: AbstinenceInformation { get }
    /// ペナルティ支払い中フラグ
    var isPaying: Bool { get }
    /// アラート情報
    var alertInfo: AlertInfo? { get }
    /// アラート表示フラグ
    var isPresentedAlert: Bool { get set }

    /// ペナルティの支払い処理
    func payPenalty()
}
