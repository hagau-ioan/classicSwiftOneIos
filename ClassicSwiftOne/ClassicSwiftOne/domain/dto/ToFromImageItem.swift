//
//  PostToImageItem.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 10.05.2024.
//

import Foundation

struct ToFromImageItem {
    
    func toImageItem(post: Post) -> ImageItem {
        return ImageItem(title: post.title, image: "", description: post.description)
    }
    
//    func toPost(image: ImageItem) -> Post {
//        return Post()
//    }
}
