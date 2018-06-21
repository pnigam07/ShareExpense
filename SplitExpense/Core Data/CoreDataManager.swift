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
    
    static let sharedInstanse =  CoreDataManager()
    var allUsers: [Users]?
    var userObject : Users?
    var creditorObject : Users?
    var debitorObject : Users?
    
    var anotherCopyOfUser : Users?
    
    
    
    func removeAllTransaction(successBlock:() -> Void, failedBlock: () -> Void) {
        
  //      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: KTRANSACTION_ENTITY_NAME)
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: KTRANSACTION_ENTITY_NAME)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
            try persistentContainer.viewContext.save()
            successBlock()
        } catch {
            failedBlock()
            print ("There was an error")
        }
    }
    
    
    func addTransaction(debitor:Users, creditor: Users, amount: Double,successBlock: () -> Void, failedBlock: (String) -> Void ) {
        
        let entityDescriptorForTransaction = NSEntityDescription.entity(forEntityName: KTRANSACTION_ENTITY_NAME, in: persistentContainer.viewContext)
        let transaction = NSManagedObject(entity: entityDescriptorForTransaction!, insertInto: persistentContainer.viewContext) as! Transaction
        transaction.amount = amount
        transaction.creditor = creditor.firstName
        transaction.debitor = debitor.firstName
        transaction.isdebitor = debitor
        transaction.isCreditor = creditor
        
        saveContext(successBlock: { (successMessage) in
            successBlock()
        }) { (errorMessage) in
            failedBlock(errorMessage)
        }
    }
    
    // FIND ALL DE
   
    
    func getAllTransaction(successWithUserProfile:(_ userProfile: [Transaction]) -> Void, failedWithError: (_ errorMessage: String?) -> Void) {
        
        getUserDetailWith(phoneNumber: Authentication().currentUser!, password: "123456789", successWithUserProfile: { (userObject) in
            self.userObject = userObject
            
            var transactionListGroupByUser : [String:[Transaction]]?
            
          
            
                
            
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: KTRANSACTION_ENTITY_NAME)
            let predicate = NSPredicate(format: "isCreditor.phoneNumber = %@ OR isdebitor.phoneNumber = %@", argumentArray: [(userObject.phoneNumber)!,(userObject.phoneNumber)!])
            fetchRequest.predicate = predicate
            
//            fetchRequest.propertiesToGroupBy = ["creditor","debitor","amount","isCreditor.phoneNumber","isdebitor.phoneNumber"]
//            fetchRequest.propertiesToFetch = ["debitor","creditor","amount","isCreditor.phoneNumber","isdebitor.phoneNumber"]
//
        //    fetchRequest.resultType = .dictionaryResultType
            
            // fetchRequest.predicate = NSPredicate(format: "isCreditor.phoneNumber = %@ AND isdebitor.phoneNumber = %@", (userObject.phoneNumber)!,(userObject.phoneNumber)!)
            do {
                
                let transactions = try persistentContainer.viewContext.fetch(fetchRequest)
        
                if  (transactions.count) != 0 {
                 
                    successWithUserProfile(transactions as! [Transaction])
                }
                else {
                    failedWithError(kRECORD_NOT_PRESENT)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                failedWithError(kGENERIC_ERROR_MESSAGE)
            }
            
            
        }) { (message) in
            print("error in fetching")
        }
        
        
    }
    
    func getAllUser(successWithUserProfile:(_ userProfile: [Users]) -> Void, failedWithError: (_ errorMessage: String?) -> Void) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: KUSER_ENTITY_NAME)
        do {
            let user = try persistentContainer.viewContext.fetch(fetchRequest) as? [Users]
            print(user ?? "no users")
            if  (user?.count)! != 0 {
                allUsers = user
                successWithUserProfile(user!)
            }
            else {
                failedWithError(kRECORD_NOT_PRESENT)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            failedWithError(kGENERIC_ERROR_MESSAGE)
        }
    }
    
    func getUserDetailWith(phoneNumber: String, password: String, successWithUserProfile:(_ userProfile: Users) -> Void, failedWithError: (_ errorMessage: String?) -> Void) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: KUSER_ENTITY_NAME)
        fetchRequest.predicate = NSPredicate(format: "phoneNumber = %@ AND password = %@",phoneNumber,password)
        
        do {
            let user = try persistentContainer.viewContext.fetch(fetchRequest) as? [Users]
            print(user ?? "no users")
            if  (user?.count)! != 0 {
                userObject = user?[0]
                successWithUserProfile((user?[0])!)
            }
            else {
                failedWithError(kRECORD_NOT_PRESENT)
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            failedWithError(kGENERIC_ERROR_MESSAGE)
        }
    }
    
    func saveUserData(_ firstName:String, _ lastName:String,_ email: String, _ phoneNumber: String, _ password:String, successWithMessage:(_ message: String) -> Void, failedWithError: (_ errorMessage: String?) -> Void)  {
        
        isDuplicatePhoneNumber(phoneNumber, successBlock: {
            let entityDescriptor = NSEntityDescription.entity(forEntityName: KUSER_ENTITY_NAME, in: persistentContainer.viewContext)
            let user = NSManagedObject(entity: entityDescriptor!, insertInto: persistentContainer.viewContext)
            
            user.setValue(firstName, forKey: "firstName")
            user.setValue(lastName, forKey: "lastName")
            user.setValue(email, forKey: "emailAddresss")
            user.setValue(phoneNumber, forKey: "phoneNumber")
            user.setValue(password, forKey: "password")
            
            saveContext(successBlock: { (successMessage) in
               successWithMessage(kSUCCESSFULLY_DATA_SAVED)
            }) { (errorMessage) in
                failedWithError(errorMessage)
            }
            
        }) {
            print("Duplicate Record")
            failedWithError(kDUPLICATE_PHONENUMBER)
        }
    }
    
    func isDuplicatePhoneNumber(_ phoneNumber : String, successBlock: () -> Void, failiourBlock: () -> Void ) {
        let user : [Users]?
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: KUSER_ENTITY_NAME)
        fetchRequest.predicate = NSPredicate(format: "phoneNumber == %@", phoneNumber)
        
        do {
            user = try persistentContainer.viewContext.fetch(fetchRequest) as? [Users]
            print(user ?? "no users")
            if  (user?.count)! == 0 {
                successBlock()
            }
            else {
                failiourBlock()
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            failiourBlock()
        }
    }
    
    
    // MARK: - Core Data stack
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: kDATABASE_NAME)
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
    
    func saveContext (successBlock:(String) -> Void, failedBlock: (_ errorMessage: String) -> Void) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                successBlock("Record added successful")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                 failedBlock(nserror.localizedDescription)
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               
            }
        }
    }
}
