//
//  KeyChainPassword.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 15.05.2024.
//

import Foundation


/*
 * The keychain access requires to be in the CONTEXT of an APPLICATION in order to be able to work
 */
struct KeyChainPassword {
    
    let thisKSecClass = kSecClassGenericPassword
    // For other type of DATA can be "kSecClassKey" or "kSecClassInternetPassword"
    // For "kSecClassInternetPassword" we need to add also the "kSecAttrService as String" (api|domain) for eaxmple
    
    func savePassword(userName: String, password: String) async -> Bool {
        let pass = password.data(using: .utf8)
        guard let pass else {
            return false
        }
        let attributes: [String: Any] = [
            kSecClass as String: thisKSecClass,
            kSecAttrAccount as String: userName, // using the key as the user name
            kSecValueData as String: pass
        ]
        
        // Always need to be 100% sure that the data which will be saved will not exist
        _ = await deletePassword(userName: userName)
        
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            return true
        } else {
            return false
        }
    }
    
    func getPassword(userName: String) async -> String {
        let query: [String: Any] = [
            kSecClass as String: thisKSecClass,
            kSecAttrAccount as String: userName,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        var item: CFTypeRef?
        // Check if user exists in the keychain
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            // Extract result
            if let existingItem = item as? [String: Any],
               // let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                return password
            }
        }
        return ""
    }
    
    func deletePassword(userName: String) async -> Bool {
        let query: [String: Any] = [
            kSecClass as String: thisKSecClass,
            kSecAttrAccount as String: userName,
        ]
        if SecItemDelete(query as CFDictionary) == noErr {
            return true
        }
        return false
    }
    
    func updatePassword(userName: String, password: String) async -> Bool {
        let query: [String: Any] = [
            kSecClass as String: thisKSecClass,
            kSecAttrAccount as String: userName
        ]
        let attributes: [String: Any] = [kSecValueData as String: password]
        if SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == noErr {
            return true
        }
        return false
    }
    
}
