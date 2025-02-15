// Created by okazakishinya on 2025/02/16.

import Foundation
import Interface
import Dependencies
import Infrastructure
import Entity

struct PayPenaltyForProductInteractor: PayPenaltyForProductUseCase {

    @Dependency(\.storeKitHelper) var storeKitHelper
    @Dependency(\.fetchAbstinenceInfoInteractor) var fetchAbstinenceInfoInteractor
    @Dependency(\.upsertAbstinenceInfoInteractor) var upsertAbstinenceInfoInteractor

    func execute(for productID: String) async -> Result<Void, PayPenaltyForProductError> {
        guard let product = try? await storeKitHelper.fetchAllProducts().first(where: { $0.id == productID }) else {
            // フェイルソフト：プロダクトIDに紐づく商品が見つからなければ、ステータスを支払済にして正常終了させる
            await updatePaidStatus()
            return .success(())
        }

        do {
            switch try await storeKitHelper.purchase(product) {
            case .success, .pending:
                await updatePaidStatus()
                return .success(())
            case .userCancelled:
                return .failure(.userCancelled)
            @unknown default:
                await updatePaidStatus()
                return .success(())
            }
        } catch {
            return .failure(.otherError)
        }
    }
}

extension PayPenaltyForProductInteractor {
    fileprivate func updatePaidStatus() async {
        guard var info = await fetchAbstinenceInfoInteractor.execute() else { return }
        info.progressStatus = .penaltyPaidForFailure
        await upsertAbstinenceInfoInteractor.execute(info)
    }
}
