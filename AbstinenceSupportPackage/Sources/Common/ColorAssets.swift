// Created by okazakishinya on 2025/02/09.

import Foundation
import SwiftUI

/// アセットカタログから色を取得する
///
/// - Note:
///     Xcode によって Asset Symbol は自動生成されるがアクセスレベルが public ではないため他モジュールからは直接参照できない
///     https://developer.apple.com/forums/thread/756954
public enum ColorAssets {
    public static let baseText = Color.baseText
}
