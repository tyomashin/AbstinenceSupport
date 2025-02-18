// Created by okazakishinya on 2025/02/18.

import Foundation
import Interface
import Entity

/// 禁欲開始画面 - 確認画面
class AbstinenceStartCompletionViewModel: AbstinenceStartCompletionViewModelProtocol {
    let abstinenceInformation: AbstinenceInformation
    let completionHandler: (_ info: AbstinenceInformation) -> Void

    init(
        abstinenceInformation: AbstinenceInformation,
        completionHandler: @escaping (_ info: AbstinenceInformation) -> Void
    ) {
        self.abstinenceInformation = abstinenceInformation
        self.completionHandler = completionHandler
    }

    func tappedCloseButton() {
        completionHandler(abstinenceInformation)
    }
}
