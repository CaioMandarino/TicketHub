//
//  KeychainService.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Foundation
import Security

enum KeychainError: Error {
    case unexpectedStatus(OSStatus)
    case dataConversionError
}

struct KeychainService {
    private static let service = "com.CaioMandarino.TicketPlace"


    static func save(_ value: String, account: String) throws {
        try? delete(account: account)
        
        let data = Data(value.utf8)

        // Query base
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: data
        ]

        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)

        switch status {
        case errSecItemNotFound:
            var addQuery = query
            addQuery[kSecValueData as String] = data

            let addStatus = SecItemAdd(addQuery as CFDictionary, nil)
            guard addStatus == errSecSuccess else {
                throw KeychainError.unexpectedStatus(addStatus)
            }

        case errSecSuccess:
            break

        default:
            throw KeychainError.unexpectedStatus(status)
        }
    }

    // MARK: - Read

    static func read(account: String) throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        switch status {
        case errSecSuccess:
            guard let data = item as? Data,
                  let string = String(data: data, encoding: .utf8) else {
                throw KeychainError.dataConversionError
            }
            return string

        case errSecItemNotFound:
            return nil

        default:
            throw KeychainError.unexpectedStatus(status)
        }
    }

    // MARK: - Delete

    static func delete(account: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}
