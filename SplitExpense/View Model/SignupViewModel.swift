//
//  SignupViewModel.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation

protocol SignupViewModelDelegate {
    func showErroMesssage(message: String)
    func signUpWithSuccess()
}

class SignupViewModel: NSObject {
    
    var delegate : SignupViewModelDelegate?
    
    var errorMessage : String?
    
    func signUp(firstName: String?,lastName: String?, phoneNumber: String?, email:String?, password: String?,confirmPassword:String?) {
        // validation
        errorMessage = nil
        
        if (UtilClass.isEmpty(firstName) || UtilClass.isEmpty(lastName) || UtilClass.isEmpty(phoneNumber) || UtilClass.isEmpty(password) || UtilClass.isEmpty(confirmPassword)) {
            errorMessage = kEMPLY_FIELD
        }
        else {
            if UtilClass.isValidEmail(email: email!) == false{
                errorMessage = kINVALID_EMAIL
            }
            else if UtilClass.isValidPhoneNumber(phoneNumber!) == false{
                errorMessage = kINVALID_PHONE_NUMBER
            }
            else if UtilClass.isPasswordSame(password: password!, confirmPassword: confirmPassword!) == false {
                errorMessage = kINVALID_PASSWORD
            }
        }
        
        if errorMessage == nil{
            CoreDataManager.sharedInstanse.saveUserData(firstName!, lastName!, email!, phoneNumber!, password!, successWithMessage: { (message) in
                self.delegate?.signUpWithSuccess()
            }) { (message) in
                self.delegate?.showErroMesssage(message: message!)
            }
        }
        else {
            delegate?.showErroMesssage(message: errorMessage!)
            // Show Error message to View
        }
    }
}
