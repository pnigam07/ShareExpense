//
//  AmountViewController.swift
//  SplitExpense
//
//  Created by pankaj on 6/25/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var amountTextField : UITextField!
    var addTransactionObject : AddTransactionTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
          navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(doneButtonAction))
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty)! {
            addTransactionObject?.amount = Double(textField.text!)
            
           // print(amount ?? "No value")
        }
    }


    @objc func doneButtonAction() {
        
     //   var amountw : Double = Double(amountTextField.text)!
        
     //   addTransactionObject?.amount = Double(amountTextField.text)
        navigationController?.popViewController(animated: true)
        
    }
    
    

}
