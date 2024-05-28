//
//  RepositoryWSP.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 08.05.2024.
//

import Foundation

import Combine

class RepositoryWSP: NSObject {
    
    private var proxy: ProxyWSP? = nil

    init(proxy: ProxyWSP?) {
        self.proxy = proxy
    }
    
    func loadListOfPosts() async -> Future<DataLoadingState<Post>, Never>? {
        return await proxy?.loadListOfPosts()
    }
    
}
