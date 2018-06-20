//
//  Transaction+CoreDataProperties.swift
//  SplitExpense
//
//  Created by pankaj on 6/20/18.
//  Copyright © 2018 Nigam. All rights reserved.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Double
    @NSManaged public var creditor: String?
    @NSManaged public var debitor: String?
    @NSManaged public var isCreditor: Users?
    @NSManaged public var isDebitor: Users?

}
