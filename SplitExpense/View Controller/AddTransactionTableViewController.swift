//
//  AddTransactionViewController.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import UIKit

class AddTransactionTableViewController: UITableViewController,UITextFieldDelegate {
    
    var amount = 100.5
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty)! {
            amount = Double(textField.text!)!
        }
    }
    
    var viewModel : AddTransactionViewModel?
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addTransaction))
    }
    
    @objc func addTransaction() {
        print("working")
        CoreDataManager.sharedInstanse.addTransaction(debitor: (viewModel?.debitor)!, creditor: (viewModel?.creditor)!, amount: amount, successBlock: {
            UtilClass.displayAlertView(titleText: kSUCCESS_TITLE, message: kSUCCESSFULLY_DATA_SAVED, viewController: self)
        }) { (errorMessage) in
             UtilClass.displayAlertView(titleText: kERROR_TITLE, message: errorMessage, viewController: self)
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
