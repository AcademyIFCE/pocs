//
//  KeychainWrapper.swift
//  KeychainPOC
//
//  Created by Thiago Henrique on 13/08/22.
//

import Foundation

struct KeychainWrapper {
    static let shared = KeychainWrapper()
    private let server = "www.server.com"
    
    func saveData(account: String, data: Data) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: account,
                                    kSecAttrServer as String: server,
                                    kSecValueData as String: data]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status)}
    }
    
    func getData() throws -> Data {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: server,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        
        var item: CFTypeRef?
        _ = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard let existingItem = item as? [String : Any],
            let tokenData = existingItem[kSecValueData as String] as? Data
        else { throw KeychainError.unexpectedData }
        
        return tokenData
    }
    
    func deleteData() throws {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: server]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
}

enum KeychainError: Error {
    case noData
    case unexpectedData
    case unhandledError(status: OSStatus)
}
