//
//  Post.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 24.04.2024.
//

import Foundation

// Should be "struct" but cannot be used for generic types
class Post: Decodable {
    
    private var body: String  = ""
    
    public private(set) var id: Int = 0
    
    public private(set) var title: String = ""
    
    // Aliase names for the fileds comming from backend

    var description: String {
        return body
    }
}

// Example of extension
extension Post {
    func test() {}
}

//extension Post: Identifiable {
//    var myid: Int { return id }
//}
