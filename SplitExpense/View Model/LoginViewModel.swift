//
//  LoginViewModel.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewModelDelegate {
    func loginSuccessFul()
}

class LoginViewModel : NSObject {

    var currentUser : NSString?
    var userProfile : Users?
    
    var delegate : LoginViewModelDelegate?
    
    // MARK: Init
    
    override init() {
        currentUser = nil //Authentication().currentUser! as NSString
    }
    
    func login(withPhoneNumber phoneNumber: String, andPassword password: String) {
        // check in core data model if user exist make successful login
        CoreDataManager.sharedInstanse.getUserDetailWith(phoneNumber: phoneNumber, password: password, successWithUserProfile: { (userProfile) in
            self.userProfile = userProfile
            delegate?.loginSuccessFul()
            
        }) { (errorMessage) in
            print("No user found")
        }
    }
    
    func logout() {
        //Remove user credentials
        
        Authentication().removeUserDetail()
        
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        let rootController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
        appDel.window?.rootViewController = rootController
    }
    
    func loginSuccessFullWithDataa(_ userId: String)  {
        print("Successfull login")
        Authentication.addUserDetailToUserDefault(userId)
    }
}
