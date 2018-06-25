//
//  SignupViewController.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import Foundation
import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet var signUpViewModel: SignupViewModel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func submiAction(_ sender: Any) {
        signUpViewModel.signUp(firstName: firstNameTextField.text, lastName: lastNameTextField.text, phoneNumber: phoneNumberTextField.text, email: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text )
    }
    
    @IBAction func backToLoginViewAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        signUpViewModel.delegate = self
        
    }
}

// MARK : sign up delegate methods

extension SignupViewController : SignupViewModelDelegate {
    
    func signUpWithSuccess() {
        DispatchQueue.main.async(execute: {() -> Void in
            let okAction = UIAlertAction(title: kOK, style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.dismiss(animated: true, completion: nil)
            }
            
            UtilClass.displayAlertViewWithCustomAction(titleText: kSUCCESS_TITLE, message: kSUCCESSFULLY_DATA_SAVED, viewController: self,action: okAction)
        })
    }
    
    func showErroMesssage(message: String) {
        UtilClass.displayAlertView(titleText: kERROR_TITLE, message: message, viewController: self)
    }
}

extension SignupViewController : UITextFieldDelegate {
    
    /**
     * Hide keyboard after user press 'return' key
     */
    
    func textFieldShouldReturn(_ theTextField: UITextField) -> Bool {
        theTextField.resignFirstResponder()
        return true
    }
    
    /**
     * Hide keyboard when text filed being clicked
     */
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    /**
     *  Hide keyboard when user touches on UI
     *
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.phase == .began
            {
                firstNameTextField.resignFirstResponder()
                lastNameTextField.resignFirstResponder()
                emailTextField.resignFirstResponder()
                phoneNumberTextField.resignFirstResponder()
                passwordTextField.resignFirstResponder()
                confirmPasswordTextField.resignFirstResponder()
            }
            super.touchesBegan(touches, with: event)
        }
    }
}
