// Created by okazakishinya on 2025/02/16.

import Testing
@testable import Domain
@testable import Entity

struct ValidateAbstinenceNameInteractorTests {
    
    @Test("空文字列の場合はエラーが返却されること")
    func empty() async throws {
        let interactor = ValidateAbstinenceNameInteractor()
        #expect(ValidationError.empty.error == interactor.execute(""))
    }

    @Test("空文字列以外の場合はエラーが返却されないこと", arguments: [
        "sample",
        "hoge",
        "テスト"
    ])
    func normal(text: String) async throws {
        let interactor = ValidateAbstinenceNameInteractor()
        #expect(interactor.execute(text) == nil)
    }

}
