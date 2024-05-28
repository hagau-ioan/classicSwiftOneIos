//
//  GeKeyChainPasswordUseCase.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 15.05.2024.
//

import Foundation

class GetKeyChainPasswordUseCase: NSObject {
    
    private var keyChain: KeyChainPassword? = nil
    
    init(keyChain: KeyChainPassword?) {
        self.keyChain = keyChain
    }
    
    func savePassword(userName: String, password: String) async -> Bool {
        return await keyChain?.savePassword(userName: userName, password: password) ?? false
    }
    
    func getPassword(userName: String) async -> String {
        return await keyChain?.getPassword(userName: userName) ?? ""
    }
    
    func deletePassword(userName: String) async -> Bool {
        return await keyChain?.deletePassword(userName: userName) ?? false
    }
    
}
