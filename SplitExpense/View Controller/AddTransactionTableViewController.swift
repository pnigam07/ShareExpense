//
//  AddTransactionViewController.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import UIKit

class AddTransactionTableViewController: UITableViewController {
    
    var viewModel : AddTransactionViewModel?
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell")
        if indexPath.row == 0 {
            cell?.textLabel?.text = "From"
            cell?.detailTextLabel?.text = "Creditor"
        }
        else if indexPath.row == 1 {
            cell?.textLabel?.text = "To"
            cell?.detailTextLabel?.text = "Debitor"
        }
        else if indexPath.row == 2 {
            cell?.textLabel?.text = "Amount"
            cell?.detailTextLabel?.text = "0.0"
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
                    navigator.pushViewController(viewController, animated: true)
                    
                }
            }
            
            
        }
        else {
            // Amount view controller
            
        }
    }
}
