//
//  DashboardViewController.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import UIKit

class DashboardViewController : UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.sharedInstanse.getAllTransaction(successWithUserProfile: { (transaction) in
            for item in transaction {
                print(item.debitor ?? "no debitor")
                print(item.amount)
            }
        }) { (message) in
            print(message ?? "ne message")
        }
        
    }
    
     @IBAction func addTransactionButtonAction(_ sender: Any) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTransactionTableViewController") as? AddTransactionTableViewController {
            viewController.viewModel = AddTransactionViewModel()
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
        
       
    }
}
