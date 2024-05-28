//
//  User.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 17.05.2024.
//

import Foundation

import CoreData

enum DataBaseResult<T> {
    case ADD
    case DELETE
    case UPDATE
    case SELECT(data: [T])
    case SUCCESS
    case ERROR
}

/*
 * https://www.hackingwithswift.com/quick-start/swiftdata/swiftdata-vs-core-data
 * One of the advantage using core data is the usage of NSFetchedResultsController and NSFetchedResultsControllerDelegate
 * having  UI: UITableViewDataSource and subcribing to the NSFetchedResultsController we will be able to get notified inside of the
 * callback methods of the UITableViewDataSource about any database change like delete, remove, add. Been notified we can request from the
 * NSFetchedResultsController instance the new fresh data. This will bring a better way of handling any database change without using an
 * additional list or disctionary/map.
 * An xample can be found here: https://github.com/andrewcbancroft/Zootastic/blob/NSFetchedResultsController_DisplayInTableView/Zootastic/MainViewController.swift
 */
struct User {
    
    static func fetchAllData() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "User")
    }
    
    static func fetchUserDetails(context: NSManagedObjectContext, userId: Int) -> DataBaseResult<UserEntity> {
        let request = NSFetchRequest<UserEntity>(entityName: "User")
        let id = Int64(userId)
        request.predicate = NSPredicate(format: "id == %ld", id) // a complicated selection here
        do {
            let users = try context.fetch(request)
            print("user id is: \(users.first?.id ?? 0)")
            return DataBaseResult.SELECT(data: users)
        } catch {
            return DataBaseResult.ERROR
        }
    }
    
    static func deleteUser(context: NSManagedObjectContext, userId: Int) -> DataBaseResult<UserEntity> {
        let request = fetchAllData()
        let id = Int64(userId)
        do {
            let users = try context.fetch(request)
            for user in users {
                if user.id == id {
                    print("Deleted User: \(user.id) \(user.full_name!) \(user.user_name!)")
                    context.delete(user)
                }
            }
            return DataBaseResult<UserEntity>.SUCCESS
        } catch {
           return DataBaseResult<UserEntity>.DELETE
        }
    }
    
    static func makeUser(
        context: NSManagedObjectContext,
        userId: Int, email: String, fullName: String, password: String, userName: String
    ) -> UserEntity {
        let user = UserEntity(context: context)
        user.id = Int64(userId)
        user.email = email
        user.full_name = fullName
        user.password = password // Need encription
        user.user_name = userName
        return user
    }
}


