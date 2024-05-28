//
//  Data.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 24.04.2024.
//

import Foundation

struct ResponseData: Decodable {
    var data: [Post]
    var code: Int
}
