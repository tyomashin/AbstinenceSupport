// Created by okazakishinya on 2025/02/16.

import Foundation
import Interface
import Entity

class AbstinenceStartRootViewModelPreview: AbstinenceStartRootViewModelProtocol {
    var navigationPath: [AbstinenceStartNavigationPath] = []

    func tappedNameEntryNextButton(title: String, detail: String?) {}
}

extension AbstinenceStartRootViewModelProtocol where Self == AbstinenceStartRootViewModelPreview {
    static var preview: Self {
        AbstinenceStartRootViewModelPreview()
    }
}
