// Created by okazakishinya on 2025/02/10.

import Foundation
import Testing
@testable import Infrastructure

/// UserDefaults の保存処理のテストコード
///
/// - Note:
///     Swift Testing はデフォルトでは並列でテスト実行されるが、
///     各テストで共通の保存領域の整合性を保つために serialized Traits を指定して順次実行するようにしている
@Suite(.serialized)
struct UserDefaultsHelperTests {
    
    let userDefaultsHelper = UserDefaultsHelper()
    
    /// 各テストケース実施前に呼ばれる
    init() {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }
    
    @Test("UserDefaults のデフォルト値をチェックする") func defaultValues() async {
        #expect(await userDefaultsHelper.getIsFirstLaunch() == true)
    }
    
    @Test("isFirstLaunch の保存処理をチェック", arguments: [true, false]) func isFirstLaunch(_ value: Bool) async {
        await userDefaultsHelper.setIsFirstLaunch(value)
        #expect(await userDefaultsHelper.getIsFirstLaunch() == value)
    }
}
