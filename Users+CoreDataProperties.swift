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
    @NSManaged public var lastName: String?
    @NSManaged public var firstName: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var creditor: NSSet?
    @NSManaged public var debitor: NSSet?

}

// MARK: Generated accessors for creditor
extension Users {

    @objc(addCreditorObject:)
    @NSManaged public func addToCreditor(_ value: Transaction)

    @objc(removeCreditorObject:)
    @NSManaged public func removeFromCreditor(_ value: Transaction)

    @objc(addCreditor:)
    @NSManaged public func addToCreditor(_ values: NSSet)

    @objc(removeCreditor:)
    @NSManaged public func removeFromCreditor(_ values: NSSet)

}

// MARK: Generated accessors for debitor
extension Users {

    @objc(addDebitorObject:)
    @NSManaged public func addToDebitor(_ value: Transaction)

    @objc(removeDebitorObject:)
    @NSManaged public func removeFromDebitor(_ value: Transaction)

    @objc(addDebitor:)
    @NSManaged public func addToDebitor(_ values: NSSet)

    @objc(removeDebitor:)
    @NSManaged public func removeFromDebitor(_ values: NSSet)

}
