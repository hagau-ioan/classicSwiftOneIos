//
//  LocalStorageData.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 08.05.2024.
//

import Foundation

class LocalStorageData: NSObject {
    
    
    func loadImages() async -> [String] {
        // Should be on another thred
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try? fm.contentsOfDirectory(atPath: path)
        var pictures = [String]()
        items?.filter { item in
            item.hasPrefix("nssl")
        }.forEach { item in
            pictures.append(item)
        }
        return pictures
    }
    
}
