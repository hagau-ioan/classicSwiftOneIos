//
//  Tracking.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 20.05.2024.
//

import Foundation

import SwiftData

@Model
class Tracking {
   
    @Attribute(.unique) var id: Int64 = 0
    var screenId: Int16 = 0
    var timeSpent: Int64 = 0
    var userId: Int64 = 0
    
    init(id: Int64, screenId: Int16, timeSpent: Int64, userId: Int64){
        self.id = id
        self.screenId = screenId
        self.timeSpent = timeSpent
        self.userId = userId
    }
    
}

extension Tracking: SwiftData.PersistentModel {
    // Some 
}

extension Tracking: Observation.Observable {
}
