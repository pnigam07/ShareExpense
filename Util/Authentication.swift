//
//  Authentication.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

class Authentication {
    
    var currentUser : String? {
        // return nil
        return UserDefaults.standard.object(forKey: CURRENT_USER) as? String
    }
    
    class func addUserDetailToUserDefault(_ userId: String) {
        UserDefaults.standard.set(userId, forKey: CURRENT_USER)
        UserDefaults.standard.synchronize()
    }
    
    func removeUserDetail() {
        UserDefaults.standard.removeObject(forKey: CURRENT_USER)
        UserDefaults.standard.synchronize()
    }
}
