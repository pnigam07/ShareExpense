//
//  DashBoardViewModel.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

protocol DashBoardDelegate {
    func updateUI()
}

class DashBoardViewModel : NSObject{
    
    var allUserTransaction : [(String):[Transaction]]?
    var totalAmount : Double?
    var totalUsers : [String]?
    var delegate : DashBoardDelegate?
    var userTotalAmount = 0.0
    
//    func simplefiedTransaction()  {
//        CoreDataManager.sharedInstanse.getAllTransaction(successWithUserProfile: { (transactions) in
//            
//            var transactionGroupByUserName =  [(String):[Transaction]]()
//            var transactionGroupByUserName1 =  [(String):[Transaction]]()
//            
//            for item in transactions{
//                let allKeys = transactionGroupByUserName.keys
//                //           let userPhoneNumber =  " \((item.isCreditor?.phoneNumber)!) + \((item.isCreditor?.firstName)!)"
//                let userPhoneNumber =  (item.isCreditor?.firstName)!
//                if allKeys.contains((item.isCreditor?.firstName)!) {
//                    var tt : [Transaction] = transactionGroupByUserName[userPhoneNumber]!
//                    tt.append(item)
//                    transactionGroupByUserName.updateValue(tt, forKey: userPhoneNumber)
//                }
//                else {
//                    let newItem : [Transaction] = [item]
//                    transactionGroupByUserName[userPhoneNumber] = newItem
//                }
//            }
//            
//            let userList =  Array(transactionGroupByUserName.keys)
//            
//            var totalDebtList = [String:[[String:[Transaction]]]]()
//            
//            for index in 0..<userList.count{
//                
//                let debitorName = userList[index]
//                
//                var dummyList = [[String:[Transaction]]]()
//                
//                for user in userList {
//                    
//                    var  dummyDict = [String:[Transaction]]()
//                    
//                    let filterArray = transactions.filter({ (transaction) -> Bool in
//                        return transaction.isdebitor?.firstName == debitorName && transaction.isCreditor?.firstName == user
//                    })
//                    
//                    dummyDict[user] = filterArray
//                    
//                    dummyList.append(dummyDict)
//                    
//                }
//                totalDebtList[debitorName] = dummyList
//            }
//            
//            print(totalDebtList)
//            
//            
//        }) { (message) in
//            print(message)
//        }
//    }
    
    
    func manageTransactionGroupwise() {
        
        CoreDataManager.sharedInstanse.getAllTransactionForCurrentUser(successWithUserProfile: { (transactions) in
                userTotalAmount = 0.0
            var transactionGroupByUserName =  [(String):[Transaction]]() // as NSDictionary
            let currectUserID : String? = CoreDataManager.sharedInstanse.userObject?.userHandle
            for item in transactions{
             
                let allKeys = Array(transactionGroupByUserName.keys)
                let userName : String?
                if item.isDebitor?.userHandle == currectUserID {
                    userTotalAmount += item.amount
                    userName = item.isCreditor?.userHandle
                }
                else {
                     userName = item.isDebitor?.userHandle
                    userTotalAmount -= item.amount
                }
                
                if allKeys.contains(userName!) {
                    var oldTransactionList : [Transaction] = transactionGroupByUserName[userName!]!
                    oldTransactionList.append(item)
                    transactionGroupByUserName.updateValue(oldTransactionList, forKey: userName!)
                }
                else {
                    let newItem : [Transaction] = [item]
                    transactionGroupByUserName[userName!] = newItem
                }
            }
            
            allUserTransaction = transactionGroupByUserName
            totalUsers = Array(transactionGroupByUserName.keys)
            delegate?.updateUI()
            print(transactionGroupByUserName)
        
        }) { (erroMessage) in
            print(erroMessage ?? "no message")
        }
    }
    
    func getTitleForSection(forUserId userId: String, withTransaction transactions: [Transaction]) -> String{
        
        let currentUserId = CoreDataManager.sharedInstanse.userObject?.firstName
        
        var totalDebt = 0.0
        
        var currentUserTotal = 0.0
        var secondUserTotal = 0.0
        
        for item in transactions {
            if item.isDebitor?.firstName == currentUserId && item.isCreditor?.firstName == userId {
                currentUserTotal = currentUserTotal + item.amount
            }
            else  if item.isDebitor?.firstName == userId && item.isCreditor?.firstName == currentUserId {
                secondUserTotal = secondUserTotal + item.amount
            }
        }
        
        totalDebt = (currentUserTotal - secondUserTotal)
        
        if  totalDebt > 0 {
            return "You Owe \(userId) \(totalDebt)"
        }
        if totalDebt < 0 {
            return "\(userId) Owe you \(secondUserTotal - currentUserTotal)"
        }
        else {
            return "No  buddy Owe Anything"
        }
    }
    
    func setAllTransaction() {
        CoreDataManager.sharedInstanse.getAllTransactionForCurrentUser(successWithUserProfile: { (transactions) in
            
           // allUserTransaction = transactions
            var transactionGroupByUserName =  [(String):[Transaction]]()
            var transactionGroupByUserName1 =  [(String):[Transaction]]()
            
            for item in transactions{
                let allKeys = transactionGroupByUserName.keys
                let userPhoneNumber =  (item.isCreditor?.firstName)!
                if allKeys.contains((item.isCreditor?.firstName)!) {
                    var tt : [Transaction] = transactionGroupByUserName[userPhoneNumber]!
                        tt.append(item)
                    transactionGroupByUserName.updateValue(tt, forKey: userPhoneNumber)
                }
                else {
                      let newItem : [Transaction] = [item]
                    transactionGroupByUserName[userPhoneNumber] = newItem
                }
            }
            
            let userList =  Array(transactionGroupByUserName.keys)
            
            var totalDebtList = [String:[[String:[Transaction]]]]()
            
            for index in 0..<userList.count{
                
                let debitorName = userList[index]
                
                var dummyList = [[String:[Transaction]]]()
                
                for user in userList {
                    
                   var  dummyDict = [String:[Transaction]]()
                    
                    let filterArray = transactions.filter({ (transaction) -> Bool in
                        return transaction.isDebitor?.firstName == debitorName && transaction.isCreditor?.firstName == user
                    })
                    
                    dummyDict[user] = filterArray
                    
                    dummyList.append(dummyDict)
                
                }
                totalDebtList[debitorName] = dummyList
            }
                
            print(totalDebtList)
            
            for user in userList {
                
                let filterArray = transactions.filter({ (transaction) -> Bool in
                    return transaction.isCreditor?.firstName == user
                })
                
                if filterArray.count > 0 {
                transactionGroupByUserName1[user] = filterArray
                }
            }
            
            allUserTransaction = transactionGroupByUserName1
            totalUsers = Array(transactionGroupByUserName1.keys)
             print(transactionGroupByUserName)
            
            
        }) { (message) in
            print(message ?? "ne message")
        }
    }
    
    override init() {
        super.init()
//        CoreDataManager.sharedInstanse.removeAllTransaction(successBlock: {
//            print("Deleted")
//        }) {
//            print("failed to delete")
//        }
 //         setAllTransaction()
    }
    
}

