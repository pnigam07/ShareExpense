//
//  DashBoardViewModel.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

class DashBoardViewModel : NSObject{
    
    var allUserTransaction : [(String):[Transaction]]?
    var totalAmount : Double?
    var totalUsers : [String]?
    
    func setAllTransaction() {
        CoreDataManager.sharedInstanse.getAllTransaction(successWithUserProfile: { (transactions) in
            
           // allUserTransaction = transactions
            var transactionGroupByUserName =  [(String):[Transaction]]()
            
            for item in transactions{
                let allKeys = transactionGroupByUserName.keys
     //           let userPhoneNumber =  " \((item.isCreditor?.phoneNumber)!) + \((item.isCreditor?.firstName)!)"
                let userPhoneNumber =  (item.isCreditor?.phoneNumber)!
                if allKeys.contains((item.isCreditor?.phoneNumber)!) {
                    var tt : [Transaction] = transactionGroupByUserName[userPhoneNumber]!
                        tt.append(item)
                    transactionGroupByUserName.updateValue(tt, forKey: userPhoneNumber)
                }
                else {
                      let newItem : [Transaction] = [item]
                    transactionGroupByUserName[userPhoneNumber] = newItem
                }
            }
            
            
            allUserTransaction = transactionGroupByUserName
            totalUsers = Array(transactionGroupByUserName.keys)
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
          setAllTransaction()
    }
    
}

