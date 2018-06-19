//
//  CoreDataManager.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    func getUserDetailWith(phoneNumber: String, password: String, successWithUserProfile:(_ userProfile: Users) -> Void, failedWithError: (_ errorMessage: String?) -> Void) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "phoneNumber == %@", phoneNumber)
        
        do {
            let user = try persistentContainer.viewContext.fetch(fetchRequest) as? [Users]
            print(user ?? "no users")
            if  (user?.count)! != 0 {
                successWithUserProfile((user?[0])!)
            }
            else {
                failedWithError("no record found")
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            failedWithError("DB Error")
        }
        
    }
    
    
    // MARK: - Core Data stack
    
    static let sharedInstanse =  CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SplitExpense")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
