//
//  DataBaseUtils.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 17.05.2024.
//

import Foundation

import CoreData

struct DataBaseUtils {
    
    static func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failure to save context: \(error)")
            }
        }
    }
}

