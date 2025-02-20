// Created by okazakishinya on 2025/02/19.

import Foundation
import Entity
import Common

@MainActor
public protocol TopViewModelProtocol: ObservableObject {
    /// 禁欲情報
    var abstinenceInformation: AbstinenceInformation { get }
    /// 初期化完了済みフラグ
    var isCompletedInitialization: Bool { get }
    /// 報告ボタン活性フラグ
    var isEnableReportButton: Bool { get }
    /// 中止ボタンの活性状態
    var restrictiveAbortState: RestrictiveAbortState { get }
    /// 処理中フラグ
    var isProcessing: Bool { get }
    /// アラート情報
    var alertInfo: AlertInfo? { get }
    /// アラート表示フラグ
    var isPresentedAlert: Bool { get set }

    /// 初回のセットアップ処理
    func setupIfNeeded() async
    /// 成功報告ボタン押下時
    func tappedSuccessReportButton()
    /// 失敗報告ボタン押下時
    func tappedFailureReportButton()
    /// 中止ボタン押下時
    func tappedAbortButton()
    /// 次の禁欲開始ボタン押下時
    func tappedNewStartButton()
}
