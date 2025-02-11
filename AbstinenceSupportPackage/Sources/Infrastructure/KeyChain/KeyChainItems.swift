// Created by okazakishinya on 2025/02/11.

enum KeyChainItems: CaseIterable {
    case abstinenceInformation

    var account: String {
        "com.tyomashin.AbstinenceSupport"
    }

    var service: String {
        switch self {
        case .abstinenceInformation:
            "abstinenceInformation"
        }
    }
}
