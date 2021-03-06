//
//  DashboardViewController.swift
//  SplitExpense
//
//  Created by pankaj on 6/19/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet var debitorTitle : UILabel!
    @IBOutlet var creditorTitle : UILabel!
    @IBOutlet var amountTitle : UILabel!
}

class DashboardViewController : UIViewController, DashBoardDelegate  {
    
    @IBOutlet var userNameTitle : UILabel!
    @IBOutlet var UserTotalAmountTitle : UILabel!
    
    @IBOutlet var viewModel : DashBoardViewModel? {
        didSet {
            print("dashborad object created")
        }
    }
    
    @IBOutlet var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        if (CoreDataManager.sharedInstanse.userObject?.userHandle) != nil{
            userNameTitle.text = CoreDataManager.sharedInstanse.userObject?.userHandle
        }
        else{
            userNameTitle.text = ""
        }
       
        navigationItem.rightBarButtonItem?.action = #selector(logoutAction)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel?.manageTransactionGroupwise()
        tableView.reloadData()
    }
    
    func updateUI() {
        userNameTitle.text = CoreDataManager.sharedInstanse.userObject?.firstName
        UserTotalAmountTitle.text = String(format: "Total Amount  %.2f",(viewModel?.userTotalAmount)!)
        tableView.reloadData()
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

extension DashboardViewController : UITabBarDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userName = viewModel?.totalUsers![section]
        let transactionList : [Transaction] = (viewModel?.allUserTransaction![userName!])!
        if transactionList.count > 0 {
            return transactionList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 20.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let totalKeys = viewModel?.allUserTransaction?.keys.count{
            return totalKeys
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let userName = viewModel?.totalUsers![section]
        let transaction = viewModel?.allUserTransaction![userName!]
       
        let sectionTitle = viewModel?.getTitleForSection(forUserId: userName!, withTransaction: transaction!)
         return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell") as! TransactionTableViewCell
        let userName = viewModel?.totalUsers![indexPath.section]
        let transactionList : [Transaction] = (viewModel?.allUserTransaction![userName!])!
        
        let transaction : Transaction? = transactionList[indexPath.row]
        
        cell.debitorTitle.text = transaction?.isDebitor?.firstName
        cell.creditorTitle.text = transaction?.isCreditor?.firstName
        cell.amountTitle.text = String(format: "%.2f", (transaction?.amount)!)
        
        return cell
    }
}
