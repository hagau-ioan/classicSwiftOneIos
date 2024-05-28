//
//  SwiftDataModelContainer.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 20.05.2024.
//

import Foundation

import SwiftData

class SwiftDataModelContainer: NSObject {
    
    static let shared = SwiftDataModelContainer()
    
    var container: ModelContainer? = nil
    
    private override init() {
        do {
            let schema = Schema([Tracking.self]) // Add more tables/models here
            // isStoredInMemoryOnly: true - if we want that the values to persisit only in the memory and not in a DB
            let configuration = ModelConfiguration()
            // For migration from one version to another
            // https://www.hackingwithswift.com/quick-start/swiftdata/how-to-create-a-complex-migration-using-versionedschema
            container = try ModelContainer(for: schema, configurations: [configuration])
            // Default name of the data bse is: default.store to use another name for the database and to save it in a custom location
            // check this: https://www.hackingwithswift.com/quick-start/swiftdata/how-to-change-swiftdatas-underlying-storage-filename
//            let url = if let url = container?.configurations.first?.url.path(percentEncoded: false) {
//                        "sqlite3 \"\(url)\""
//                    } else {
//                        "No SQLite database found."
//                    }
//            print(url)
        } catch {
            
        }
    }
    
    @MainActor
    func loadTrackings() async -> [Tracking]{
        let descriptor = FetchDescriptor<Tracking>()
        let trakings = (try? container?.mainContext.fetch(descriptor)) ?? []
        return trakings
    }
    
    @MainActor
    func loadTrackingDetails(id: Int64) async -> Tracking? {
        var descriptor = FetchDescriptor<Tracking>()
        descriptor.predicate = #Predicate { item in
            item.id == id
        }
        return (try? container?.mainContext.fetch(descriptor))?.first
    }
    
    /*
     * 1. Adding a duplicate unique key will overidde the previous entry with same unique id key
     * 2. For the SwiftUI there are some states anotations like @Query which will be bound to any change of the table and will refresh the list
     *      used in UI to display the data: https://bugfender.com/blog/swift-data/#:~:text=Introduced%20in%202023%2C%20SwiftData%20is,primary%20programming%20language%20for%20iOS.
     * Ex: @Query (filter: #Predicate<Post> { post in
             post.author.username == "CascadeMystic"
        })
     * 3. The operations on data base are not over the MainThread which brings some concurential limitations for same table changes.
     *
     */
    @MainActor
    func addTracking(id: Int64, screenId: Int16, timeSpent: Int64, userId: Int64) async {
        let track = Tracking(id: id, screenId: screenId, timeSpent: timeSpent, userId: userId)
        if let cont = container {
            /* The ModelContext created is an INDEPENDENT instance, different from the context instance
             * provided by the ****mainContext*** property of the ModelContainer instance.
             * Although they operate on the main queue, they manage separate sets of registered objects.
             * Another elegant solution to provide a valid context is the usage of @ModelActor.
             * See https://betterprogramming.pub/concurrent-programming-in-swiftdata-c9bf021a4c2d
             */
            let privateContext = ModelContext(cont) // Create a private context for multiple concurency request
            // best practice --> @ModelActor for independed context
            privateContext.insert(track)
        }
        
    }
    
    @MainActor
    func deleteTracking(id: Int64) async {
        let trackings = await loadTrackings()
        for tracking in trackings {
            if id == tracking.id {
                container?.mainContext.delete(tracking)
            }
        }
    }
}
