//
//  MenuItem.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 04.06.2024.
//

import Foundation

struct MenuItem {
    
    let id: Int
    
    let name: String
    
    let icon: String
    
    var selected: Bool = false
    
    let onClick: (MenuItem) -> Void

    mutating func setSelected(selected: Bool) {
        self.selected = selected
    }
}
