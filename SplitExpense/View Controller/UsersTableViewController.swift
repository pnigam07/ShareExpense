//
//  UsersTableViewController.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController, UserTableViewModelDelegate{
    
    var viewModel : UserTableViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var userList : [Users]?
    
    func updateTableView() {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let _ = viewModel?.allUsers {
            return (viewModel?.allUsers!.count)!
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell")
        let userDetail = viewModel?.allUsers![indexPath.row] as Users?
        
        cell?.textLabel?.text = userDetail?.firstName
        cell?.detailTextLabel?.text = userDetail?.phoneNumber
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Move to user Table if fiest and second row is clicked
        if indexPath.row == 0 || indexPath.row == 1 {
            // go to User list table view
            
        }
        else {
            // Amount view controller
            
        }
    }
    
}


