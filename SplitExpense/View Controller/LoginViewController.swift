//
//  ViewController.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var viewModel : LoginViewModel? {
        didSet {
            fillUI()
        }
    }
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
    }
    
    func fillUI(){
        print("Fill UI Test")
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if false == UtilClass.isEmpty(userNameTextField.text!) && false == UtilClass.isEmpty(passwordTextField.text!)
        {
            
            view.isUserInteractionEnabled = false
            UtilClass.utilitySharedInstance.showActivityIndicator(uiView: self.view)
            viewModel?.login(withPhoneNumber: userNameTextField.text!, andPassword: passwordTextField.text!)
        }
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
    }
}

extension LoginViewController : LoginViewModelDelegate {
    
    /**
     * onLogin delegate implementation.
     */
    
    func onLogin() {
        
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.userNameTextField.delegate = nil
            self.passwordTextField.delegate = nil
            UtilClass.utilitySharedInstance.hideActivityIndicator()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let rootController = UIStoryboard(name: KMAINSTORYBOARDNAME, bundle: Bundle.main).instantiateViewController(withIdentifier: kDASHBOARD_VIEW_CONTROLLER_IDENTIFIER)
            appDelegate.window?.rootViewController = rootController
        })
    }
    
    /**
     * onLoginFailed delegate implementation.
     */
    func onLoginFailed() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.userNameTextField.delegate = self
            self.passwordTextField.delegate = self
            UtilClass.utilitySharedInstance.hideActivityIndicator()
            UtilClass.displayAlertView(titleText: kERROR_TITLE, message: self.viewModel?.errorMessage ?? kGENERIC_ERROR_MESSAGE, viewController: self)
            self.view.isUserInteractionEnabled = true
        })
    }
}

extension LoginViewController : UITextFieldDelegate {
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
            // ...
            if touch.phase == .began
            {
                userNameTextField.resignFirstResponder()
                passwordTextField.resignFirstResponder()
            }
        }
        super.touchesBegan(touches, with: event)
    }
}
