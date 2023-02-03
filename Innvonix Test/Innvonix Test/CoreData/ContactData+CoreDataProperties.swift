//
//  ContactData+CoreDataProperties.swift
//  Innvonix Test
//
//  Created by Anant Bhatt on 03/02/23.
//
//

import Foundation
import CoreData


extension ContactData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactData> {
        return NSFetchRequest<ContactData>(entityName: "ContactData")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var familyName: String?
    @NSManaged public var phoneNumber: String?

}

extension ContactData : Identifiable {

}
