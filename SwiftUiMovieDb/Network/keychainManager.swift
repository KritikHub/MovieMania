//
//  keychainManager.swift
//  SwiftUiMovieDb
//
//  Created by mac on 10/01/24.
//

import Foundation

class KeychainManager {
    
    func saveDataToKeychain(_ data: String, service: String ,account: String) {
        guard let dataToSave = data.data(using: .utf8) else {
            print("Error converting string data to Data")
            return
        }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecValueData as String: dataToSave
        ]
        let saveStatus = SecItemAdd(query as CFDictionary, nil)
        if saveStatus == errSecDuplicateItem {
            print("Keychain error duplicate item")
        }
        if saveStatus == errSecSuccess {
            print("Data saved to Keychain successfully")
        } else {
            print("Keychain error: \(saveStatus)")
        }
    }
    
    func updateDataToKeychain(_ data: String, service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
        ]
        let updateData = [kSecValueData: data] as CFDictionary
        let updateStatus = SecItemUpdate(query as CFDictionary, updateData)
        if updateStatus == errSecSuccess {
            print("Data saved to Keychain successfully")
        } else {
            print("Keychain error: \(updateStatus)")
        }
    }
    
    func getDataFromKeychain(service: String, account: String) -> String?{
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess, let data = result as? Data else {
            print("Error retrieving password from keychain: \(status)")
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func deleteDataFromKeychain(service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
        ]        
        let deleteStatus = SecItemDelete(query as CFDictionary)
        if deleteStatus == errSecSuccess {
            print("Data deleted from Keychain successfully")
        } else {
            print("Keychain delete error: \(deleteStatus)")
        }
    }
}
