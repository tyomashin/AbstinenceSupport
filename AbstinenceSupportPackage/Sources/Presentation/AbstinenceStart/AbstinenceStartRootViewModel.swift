// Created by okazakishinya on 2025/02/16.

import Foundation
import Interface
import Entity

class AbstinenceStartRootViewModel: AbstinenceStartRootViewModelProtocol {
    @Published var navigationPath: [AbstinenceStartNavigationPath] = []

    /// やめること
    private var abstinenceTitle: String = ""
    /// やめることの詳細（任意）
    private var detail: String?

    func tappedNameEntryNextButton(title: String, detail: String?) {
        self.abstinenceTitle = title
        self.detail = detail

        navigationPath.append(.targetDaysEntry)
    }

}
