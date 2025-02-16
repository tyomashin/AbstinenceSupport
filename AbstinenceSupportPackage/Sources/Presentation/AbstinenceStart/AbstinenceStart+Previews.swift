// Created by okazakishinya on 2025/02/16.

import Foundation
import Interface
import Entity

class AbstinenceStartRootViewModelPreview: AbstinenceStartRootViewModelProtocol {
    var navigationPath: [AbstinenceStartNavigationPath] = []
    var targetDays: Int = 10

    func tappedNameEntryNextButton(title: String, detail: String?) {}
    func tappedTargetDaysNextButton(targetDays: Int) {}
}

extension AbstinenceStartRootViewModelProtocol where Self == AbstinenceStartRootViewModelPreview {
    static var preview: Self {
        AbstinenceStartRootViewModelPreview()
    }
}
