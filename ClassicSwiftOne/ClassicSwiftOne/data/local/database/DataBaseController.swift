//
//  CoreDataModelController.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 16.05.2024.
//

import CoreData

class DataBaseController: ObservableObject {
    
    /*
     * let data = CoreDataModelController()
     * data.objectWillChange.sink { _ in
     *    print("\(data.field) will change")
     * }
     */
    @Published var userName: String = "" // Because of "ObservableObject" just for testing
    
    static let shared = DataBaseController()
    
    
    func testDatabaseWork() async {
        let dbCore = CoreDataModelContainer.shared
        // Example of usage of CoreData
        await dbCore.deleteUser(userId: 1)
        await dbCore.saveUser(userId: 1, email: "hagau@hagau.ro", fullName: "Hagau Ioan", password: "123456", userName: "ihagauusername")
        await dbCore.getUserDetails(userId: 1)
        await dbCore.loadUsers()
        
        // Example of usage of SwiftData: modern approch.
        // SwiftData uses the proven storage architecture of Core Data, so you can use both in the same app with the same underlying storage.
        // To use the same storage check [SwiftDataModelContainer.swift:18]
        Task {
            let dbData = SwiftDataModelContainer.shared
            await dbData.addTracking(id: Int64(1), screenId: Int16(1), timeSpent: Int64(100), userId: Int64(1))
            
            await dbData.addTracking(id: Int64(2), screenId: Int16(2), timeSpent: Int64(200), userId: Int64(2))
            
            await dbData.deleteTracking(id: Int64(1))
            
            let trackings = await dbData.loadTrackings()
            for tracking in trackings {
                print("Tracking item: \(tracking.screenId)")
            }
            
            let trackingDetails = await dbData.loadTrackingDetails(id: 2)
            if let trackingDetails = trackingDetails {
                print("Details of \(trackingDetails.userId)")
            }
        }
        
    }
    
}
