// Created by okazakishinya on 2025/02/13.

import Foundation
import Interface

class RootViewModelPreview: RootViewModelProtocol {}

extension RootViewModelProtocol where Self == RootViewModelPreview {
    static var preview: Self {
        RootViewModelPreview()
    }
}
