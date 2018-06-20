//
//  DashBoardViewModel.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

class DashBoardViewModel : NSObject{
    
    var allUserTransaction : [Transaction]?
    var totalAmount : Double?
    
    func setAllTransaction() {
        CoreDataManager.sharedInstanse.getAllTransaction(successWithUserProfile: { (transactions) in
            
          allUserTransaction = transactions
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

