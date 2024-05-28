//
//  CoreDataModelContainer.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 20.05.2024.
//

import Foundation
import CoreData

// NOTE: usualy is better to have a private persistentContainer.viewContext.
// In case of multithreading we may have a conflict of iterests.
// Need to be sure that all database work is done on his own isolated context for each thread
// Need to keep an eye on this.
// By defualt the context is configured for: NSMainQueueConcurrencyType (main Thread)
// https://ali-akhtar.medium.com/mastering-in-coredata-part-11-multithreading-concurrency-rules-70f1f221dbcd

class CoreDataModelContainer: NSObject {
    
    static let shared = CoreDataModelContainer()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel") // Require the .xcdatamodelId file.
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private override init() {
    }
    
    func saveUser(userId: Int, email: String, fullName: String, password: String, userName: String) async {
        
        let context = container.viewContext;
        _ = User.makeUser(
            context: context,
            userId: userId,
            email: email,
            fullName: fullName,
            password: password,
            userName: userName)
        
        DataBaseUtils.save(context: context)
    }
    
    func deleteUser(userId: Int) async {
        let context = container.viewContext;
        _ = User.deleteUser(context: context, userId: userId)
        DataBaseUtils.save(context: context)
    }
    
    func getUserDetails(userId: Int) async {
        let context = container.viewContext;
        let result = User.fetchUserDetails(context: context, userId: userId)
        print("getUserDetails: userId: \(userId) with \(result)")
    }
    
    func loadUsers() async {
        let context = container.viewContext;
        let request = User.fetchAllData()
        do {
            let users = try context.fetch(request)
            for (_, user) in users.enumerated() {
                print("User: \(user.id) \(user.full_name!) \(user.user_name!)")
            }
            
        } catch let error as NSError {
            print("Error users fetch \(error)")
        }
    }
}
