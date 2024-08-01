//
//  ImageItem.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 10.05.2024.
//

import Foundation

// Should be struct like a tuple ImageItem(title: ....) but because of the generic usage must be a class
class ImageItem: Decodable {
    var title: String = ""
    var image: String = ""
    var description: String = ""
    
    init(title: String, image: String, description: String) {
        self.title = title
        self.image = image
        self.description = description
    }
}
