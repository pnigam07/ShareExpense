//
//  UserTableViewModel.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

protocol UserTableViewModelDelegate {
    func updateTableView()
}

class UserTableViewModel {
    
    var allUsers : [Users]?
    
    
    var delegate : UserTableViewModelDelegate?
    
    init() {
        CoreDataManager.sharedInstanse.getAllUser(successWithUserProfile: { (allUsers) in
            self.allUsers = allUsers
        }) { (message) in
            print(message ?? "nothing")
        }
    }
}
