// Created by okazakishinya on 2025/02/22.

import Foundation
import Dependencies
import Interface
import Entity
import Domain
import Common

class FailureViewModel: FailureViewModelProtocol {
    @Published var abstinenceInformation: AbstinenceInformation
    @Published var isPaying = false
    @Published var isPresentedAlert = false
    public var alertInfo: AlertInfo? {
        didSet {
            self.isPresentedAlert = alertInfo != nil
        }
    }

    @Dependency(\.payPenaltyForProductInteractor) var payPenaltyForProductInteractor
    @Dependency(\.upsertAbstinenceInfoInteractor) var upsertAbstinenceInfoInteractor
    @Dependency(\.notifyChangedAppTransitionState) var notifyChangedAppTransitionState

    init(abstinenceInformation: AbstinenceInformation) {
        self.abstinenceInformation = abstinenceInformation
        self.isPaying = isPaying
    }

    func payPenalty() {
        guard !isPaying else { return }
        isPaying = true

        Task {
            switch abstinenceInformation.penaltyInfo.penaltyCategory {
            // 無料ペナルティの場合は即座に支払い完了にする
            case .free:
                abstinenceInformation.progressStatus = .penaltyPaidForFailure
                await upsertAbstinenceInfoInteractor.execute(abstinenceInformation)
                completedPayPenalty()
            // 有料ペナルティの場合は StoreKit に対して支払い要求をする
            case .product(let productID):
                await pay(for: productID)
            }
            isPaying = false
        }
    }
}

extension FailureViewModel {
    /// 有料ペナルティを購入する
    fileprivate func pay(for productID: String) async {
        let result = await payPenaltyForProductInteractor.execute(for: productID)
        switch result {
        case .success:
            // 成功時は画面遷移する。禁欲ステータスの更新は Interactor 側で実施
            completedPayPenalty()
        case .failure:
            // 失敗時はアラート表示
            alertInfo = .init(
                title: LocalizedString.failurePayFailedAlertTitle.localizedString,
                message: LocalizedString.failurePayFailedAlertDetail.localizedString,
                buttonList: [
                    .init(
                        title: LocalizedString.okButton.localizedString,
                        role: .none,
                        action: nil
                    )
                ]
            )
        }
    }

    /// 禁欲のペナルティ支払い完了後の処理
    fileprivate func completedPayPenalty() {
        // アラートで支払い完了した旨を表示する
        alertInfo = .init(
            title: LocalizedString.failurePayCompletionAlertTitle.localizedString,
            message: LocalizedString.failurePayCompletionAlertDetail.localizedString,
            buttonList: [
                .init(
                    title: LocalizedString.okButton.localizedString,
                    role: .none,
                    action: { [weak self] in
                        // 画面遷移要求
                        self?.notifyChangedAppTransitionState()
                    }
                )
            ]
        )
    }
}
