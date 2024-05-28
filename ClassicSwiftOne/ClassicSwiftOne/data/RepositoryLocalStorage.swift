//
//  RepositoryLocalStorage.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 08.05.2024.
//

import Foundation

import Combine

class RepositoryLocalStorage: NSObject {
    
    private var localStorage: LocalStorageData? = nil

    init(localStorage: LocalStorageData?) {
        self.localStorage = localStorage
    }
    
    func loadImages() async -> [String]? {
        return await localStorage?.loadImages()
    }
    
}
