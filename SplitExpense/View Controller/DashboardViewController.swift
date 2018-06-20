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
        
        navigationItem.rightBarButtonItem?.action = #selector(logoutAction)
    }
    
   @IBAction func logout(_ sender: Any) {
        logoutAction()
    }
    
    @objc func logoutAction()  {
        Authentication().removeUserDetail()
        
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        let rootController = UIStoryboard(name: KMAINSTORYBOARDNAME, bundle: Bundle.main).instantiateViewController(withIdentifier: kLOGIN_VIEW_CONTROLLER_IDENTIFIER)
        appDel.window?.rootViewController = rootController
        
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
