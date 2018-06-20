//
//  Users+CoreDataProperties.swift
//  SplitExpense
//
//  Created by pankaj on 6/20/18.
//  Copyright © 2018 Nigam. All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var emailAddresss: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var userId: String?
    @NSManaged public var userToken: String?
    @NSManaged public var creditor: Transaction?
    @NSManaged public var debitor: Transaction?

}
