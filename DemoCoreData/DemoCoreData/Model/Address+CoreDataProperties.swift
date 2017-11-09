//
//  Address+CoreDataProperties.swift
//  DemoCoreData
//
//  Created by Lucio Pham on 11/9/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var home: String?
    @NSManaged public var student: NSSet?

}

// MARK: Generated accessors for student
extension Address {

    @objc(addStudentObject:)
    @NSManaged public func addToStudent(_ value: Student)

    @objc(removeStudentObject:)
    @NSManaged public func removeFromStudent(_ value: Student)

    @objc(addStudent:)
    @NSManaged public func addToStudent(_ values: NSSet)

    @objc(removeStudent:)
    @NSManaged public func removeFromStudent(_ values: NSSet)

}
