// Created by okazakishinya on 2025/02/11.

import Foundation
import Interface

struct KeyChainHelper: KeyChainHelperProtocol {

    let teamID = "38BV25GUUS.com.tyomashin.AbstinenceSupport.SharedItems"

    func save<Item: Codable>(abstinenceInformation: Item) {
        save(
            item: abstinenceInformation,
            service: KeyChainItems.abstinenceInformation.service,
            account: KeyChainItems.abstinenceInformation.account
        )
    }

    func readAbstinenceInformation<Item: Codable>() -> Item? {
        read(service: KeyChainItems.abstinenceInformation.service, account: KeyChainItems.abstinenceInformation.account)
    }

    func save<Item: Codable>(abortDate: Item) {
        save(
            item: abortDate,
            service: KeyChainItems.abortDate.service,
            account: KeyChainItems.abortDate.account
        )
    }

    func readAbortDate<Item: Codable>() -> Item? {
        read(service: KeyChainItems.abortDate.service, account: KeyChainItems.abortDate.account)
    }
}

extension KeyChainHelper {
    func save<Item: Codable>(item: Item, service: String, account: String) {
        guard let data = try? JSONEncoder().encode(item) else { return }
        let query =
            [
                kSecValueData: data,
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
                kSecAttrAccessGroup: teamID,
            ] as CFDictionary

        let matchingStatus = SecItemCopyMatching(query, nil)
        switch matchingStatus {
        case errSecItemNotFound:
            let result = SecItemAdd(query, nil)
            print("keychain save result: \(result)")
        case errSecSuccess:
            let result = SecItemUpdate(query, [kSecValueData: data] as CFDictionary)
            print("keychain update result: \(result)")
        default:
            print("failed keychain access: \(matchingStatus)")
        }
    }

    func read<Item: Codable>(service: String, account: String) -> Item? {
        let query =
            [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
                kSecReturnData: true,
                kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
                kSecAttrAccessGroup: teamID,
            ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        guard let data = result as? Data else { return nil }
        return try? JSONDecoder().decode(Item.self, from: data)
    }

    func deleteAll() {
        for item in KeyChainItems.allCases {
            delete(service: item.service, account: item.account)
        }
    }

    func delete(service: String, account: String) {
        let query =
            [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
                kSecAttrAccessGroup: teamID,
            ] as CFDictionary
        SecItemDelete(query)
    }
}
