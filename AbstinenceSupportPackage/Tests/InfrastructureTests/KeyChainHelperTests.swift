// Created by okazakishinya on 2025/02/11.

import Foundation
import Testing
@testable import Infrastructure

/// - Note:
///     ユニットテスト時に KeyChain にアクセスすると、OSStatus -34018 エラーが発生する
///     ユニットテスト時に見られるエラーのようで、対処法が確立できるまで disable にしておく
@Suite(.serialized, .disabled())
struct KeyChainHelperTests {

    let keyChainHelper = KeyChainHelper()
    let account = "test.account"
    let service = "test.data"
    let testData: Data

    init() {
        testData = "テストデータ".data(using: .utf8)!
        keyChainHelper.delete(service: service, account: account)
    }
    
    @Test("KeyChain に対して任意の Data を保存・取得する処理を確認") func saveAnyData() async throws {
        keyChainHelper.save(item: testData, service: service, account: account)
        let savedData: Data = try #require(keyChainHelper.read(service: service, account: account))
        #expect(savedData == testData)
    }
}
