//
//  AddTransactionViewController.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import UIKit

class AddTransactionTableViewController: UITableViewController,UITextFieldDelegate {
    
    var amount : Double?
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty)! {
            amount = Double(textField.text!)
            print(amount ?? "No value")
        }
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return false
//    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text ?? "hkljnl")
        return true
    }
//

    
  
    
    var viewModel : AddTransactionViewModel?
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addTransaction))
    }
    
    func getAmountValue() -> UITextField {
        
        let indexpathForAmount = NSIndexPath(row: 2, section: 0)
        let amountCell = self.tableView(tableView, cellForRowAt: indexpathForAmount as IndexPath)
        let amounttextField = amountCell.viewWithTag(99) as! UITextField
        amounttextField.resignFirstResponder()
        amounttextField.endEditing(true)
        
   //     textFieldShouldEndEditing(amounttextField)
        
        print(amounttextField.text ?? "No value")
        
        return amounttextField
      
       
    }
    
    @objc func addTransaction() {
        print("working")
        
        
        if viewModel?.debitor != nil || viewModel?.creditor != nil || !(getAmountValue().text?.isEmpty)! {
            CoreDataManager.sharedInstanse.addTransaction(debitor: (viewModel?.debitor)!, creditor: (viewModel?.creditor)!, amount: amount!, successBlock: {
            UtilClass.displayAlertView(titleText: kSUCCESS_TITLE, message: kSUCCESSFULLY_DATA_SAVED, viewController: self)
        }) { (errorMessage) in
             UtilClass.displayAlertView(titleText: kERROR_TITLE, message: errorMessage, viewController: self)
            }
        }
        }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "customCell")
        if indexPath.row == 0 {
            cell?.textLabel?.text = "From"
            if viewModel?.debitor != nil {
                cell?.detailTextLabel?.text = viewModel?.debitor?.firstName
            }
            else {
                cell?.detailTextLabel?.text = "Debitor"
            }
        }
        else if indexPath.row == 1 {
            cell?.textLabel?.text = "To"
            if viewModel?.creditor != nil {
                cell?.detailTextLabel?.text = viewModel?.creditor?.firstName
            }
            else {
                cell?.detailTextLabel?.text = "Creditor"
            }
        }
        else if indexPath.row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "cellWithTextField")
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Move to user Table if fiest and second row is clicked
        if indexPath.row == 0 || indexPath.row == 1 {
            // go to User list table view
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UsersTableViewController") as? UsersTableViewController {
                viewModel?.selectedRow = indexPath.row
                
                if let navigator = navigationController {
                    viewController.viewModel = UserTableViewModel()
                    viewController.viewModel?.addTransactionVCReferanceObject = self
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
    }
}
