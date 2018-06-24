//
//  SimplyfyDebtViewController.swift
//  SplitExpense
//
//  Created by pankaj on 6/21/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import UIKit

class SimplyfiedTableViewCell: UITableViewCell {
    @IBOutlet var hostName : UILabel!
    @IBOutlet var hostAmount : UILabel!
//    @IBOutlet var receiverName : UILabel!
//    @IBOutlet var receiverAmount : UILabel!
//    @IBOutlet var finallyGoingTo : UILabel!
    
}

class SimplyfyDebtViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var allTransaction = [String:[[String:[Transaction]]]]() as NSDictionary
    
    var currentSectionNumber : Int?
    
    
    
    @IBOutlet var simplyfiedTableView : UITableView?
    @IBOutlet var chieldSimplyfiedTableView : UITableView?
    
    override func viewDidLoad() {
        simplefiedTransaction()
    }
    
  //  if allTransaction.keys.count > 0 {
//    let totalListOfDebitor : [String]?  = Array(allTransaction.keys)
//
//    let totalNumberOfParantTableViewSection = totalListOfDebitor?.count
//
//    let firstDebitor = allTransaction[totalListOfDebitor![0]]
//
//    let listOfCreditor = firstDebitor![0]
//
//    let firstCreditor = firstDebitor![0]
//
//    let finalListOfCreditor = Array(firstCreditor.keys)
//
//    let firstListOfTransaction = firstCreditor[finalListOfCreditor[0]]
//
//    for item in firstListOfTransaction! {
//    print(item)
//    }
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
     //   return 0
        if tableView.tag == 98 {
            return 1
        }
        else if tableView.tag == 99 {
            
            let allParentDebitor = allTransaction.allKeys
            let currentParantKey = allParentDebitor[currentSectionNumber!]
            
            let currentDisplayingSubCreditor = allTransaction.object(forKey: currentParantKey) as? [[String:[Transaction]]]
            
     //       let currentListOfCreditor = currentDisplayingSubCreditor![section] as NSDictionary
            
            return (currentDisplayingSubCreditor?.count)!
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
    //    return 1
        if tableView.tag == 98 {
            
            let totalDebitor = allTransaction.allKeys.count
            
            return totalDebitor
        }
        else if tableView.tag == 99 {
            
            //[String:[[String:[Transaction]]]]
            
            let totalListOfDebitor   = allTransaction.allKeys
            
            _ = totalListOfDebitor.count
            
            let listOfDebitor = allTransaction[totalListOfDebitor[currentSectionNumber!]]
            
            return ((listOfDebitor as AnyObject).count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if tableView.tag == 98 {
            currentSectionNumber = 1
            let allParentDebitor = allTransaction.allKeys
            print(allParentDebitor[section])
            return allParentDebitor[section] as? String
        }
        else if tableView.tag == 99 {
            
             //[String:[[String:[Transaction]]]]
            
//            tableView.presentationIndexPath(forDataSourceIndexPath: <#T##IndexPath?#>)
            
            let allParentDebitor = allTransaction.allKeys
            let currentParantKey = allParentDebitor[currentSectionNumber!]
            
            let currentDisplayingSubCreditor = allTransaction.object(forKey: currentParantKey) as? [[String:[Transaction]]]
            
            let currentListOfCreditor = currentDisplayingSubCreditor![section] as NSDictionary
            
            let titleForSection = currentListOfCreditor.allKeys[0]
            
            return titleForSection as? String
            
          //  [[String:[Transaction]]]
            
       //     let cuurent
       //     let currentSectionNumber = currentDisplayingSubCreditor![section]
            
        
            
        }
        
        
        
        return "nothing is found"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if tableView.tag == 98 {
            cell = tableView.dequeueReusableCell(withIdentifier: "simplyfiedCell1")!
        }
        else if tableView.tag == 99 {
            
            var cellOfCurrent = tableView.superview?.superview?.superview
            var another = tableView.superview?.superview
            var oneUpper = tableView.superview
            
            if cellOfCurrent is UITableViewCell{
                cellOfCurrent =  cellOfCurrent as! UITableViewCell
                print(cellOfCurrent)
            }
            
            if another is UITableViewCell{
                
                another = another as! UITableViewCell
                
                let path = tableView.indexPath(for: another as! UITableViewCell)
                
                let dd = simplyfiedTableView?.indexPath(for: another as! UITableViewCell)
                print(cellOfCurrent?.frame)
            }
            if oneUpper is UITableViewCell{
                print(cellOfCurrent?.frame)
            }
            
            
            cell = tableView.dequeueReusableCell(withIdentifier: "simplyfiedCell2")! as! SimplyfiedTableViewCell
            
            let allParentDebitor = allTransaction.allKeys
            let currentParantKey = allParentDebitor[currentSectionNumber!]
            
            let currentDisplayingSubCreditor = allTransaction.object(forKey: currentParantKey) as? [[String:[Transaction]]]
            
            let currentListOfCreditor = currentDisplayingSubCreditor![indexPath.section] as NSDictionary
            
            let titleForSection = currentListOfCreditor.allKeys[0]
            
            let listOfTransaction = currentListOfCreditor.object(forKey: titleForSection) as! [Transaction]
            
//            let currentTransaction = listOfTransaction[indexPath.row]
//        //    cell.hostName = listOfTransaction[indexPath.row].creditor
            cell.detailTextLabel?.text =  "daa" //String(currentTransaction.amount)
            cell.textLabel?.text = "titi" //currentTransaction.creditor
            
            
        }
       
        
        
        return cell
        
    }
    
    
    func simplefiedTransaction()  {
        CoreDataManager.sharedInstanse.getAllTransaction(successWithUserProfile: { (transactions) in
            
            var transactionGroupByUserName =  [(String):[Transaction]]()
            var transactionGroupByUserName1 =  [(String):[Transaction]]()
            
            for item in transactions{
                let allKeys = transactionGroupByUserName.keys
                //           let userPhoneNumber =  " \((item.isCreditor?.phoneNumber)!) + \((item.isCreditor?.firstName)!)"
                let userPhoneNumber =  (item.isCreditor?.firstName)!
                if allKeys.contains((item.isCreditor?.firstName)!) {
                    var tt : [Transaction] = transactionGroupByUserName[userPhoneNumber]!
                    tt.append(item)
                    transactionGroupByUserName.updateValue(tt, forKey: userPhoneNumber)
                }
                else {
                    let newItem : [Transaction] = [item]
                    transactionGroupByUserName[userPhoneNumber] = newItem
                }
            }
            let userList =  Array(transactionGroupByUserName.keys)
            var totalDebtList = [String:[[String:[Transaction]]]]()
            
            
           

            
            
            
            
            
            
            for index in 0..<userList.count{
                
                let debitorName = userList[index]
                
                var dummyList = [[String:[Transaction]]]()
                
                
                
                for user in userList {
                    
                    var  dummyDict = [String:[Transaction]]()
                    
                    let filterArray = transactions.filter({ (transaction) -> Bool in
                        return transaction.isdebitor?.firstName == debitorName && transaction.isCreditor?.firstName == user
                    })
                    if filterArray.count > 0 {
                        dummyDict[user] = filterArray
                    
                        dummyList.append(dummyDict)
                    }
                }
                if dummyList.count > 0 {
                    totalDebtList[debitorName] = dummyList
                }
                
                print(totalDebtList)
                print("//////////////////////////////////////")
                
            }
            
            
            
            
            allTransaction = totalDebtList as NSDictionary
            simplyfiedTableView?.reloadData()
            
        }) { (message) in
            print(message)
        }
        
        
        
        
    }
    
    
}

//extension SimplyfyDebtViewController : UITableViewDelegate,UITableViewDataSource {
//
//
//
//}
