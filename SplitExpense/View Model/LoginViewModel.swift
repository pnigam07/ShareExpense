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
    func onLogin()
    func onLoginFailed()
}

class LoginViewModel : NSObject {

    var currentUser : NSString?
    var userProfile : Users?
    var errorMessage : String?
    
    var delegate : LoginViewModelDelegate?
    
    // MARK: Init
    
    override init() {
        currentUser = Authentication().currentUser as NSString?
    }
    
    func login(withPhoneNumber phoneNumber: String, andPassword password: String) {
        // check in core data model if user exist make successful login
        CoreDataManager.sharedInstanse.authenticateUser(phoneNumber: phoneNumber, password: password, successWithUserProfile: { (userProfile) in
            self.userProfile = userProfile
            Authentication.addUserDetailToUserDefault(userProfile.phoneNumber!)
            delegate?.onLogin()
            
        }) { (errorMessage) in
            self.errorMessage = kRECORD_NOT_PRESENT
            delegate?.onLoginFailed()
        }
    }
    
    func logout() {
        //Remove user credentials
        Authentication().removeUserDetail()
        
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        let rootController = UIStoryboard(name: KMAINSTORYBOARDNAME, bundle: Bundle.main).instantiateViewController(withIdentifier: kLOGIN_VIEW_CONTROLLER_IDENTIFIER)
        appDel.window?.rootViewController = rootController
    }
}
