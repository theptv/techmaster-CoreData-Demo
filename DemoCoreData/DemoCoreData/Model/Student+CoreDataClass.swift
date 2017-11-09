//
//  Student+CoreDataClass.swift
//  DemoCoreData
//
//  Created by Lucio Pham on 11/9/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Student)
public class Student: NSManagedObject {
  
  convenience init(_ entity: NSEntityDescription, firstName: String, lastName: String ) {
    self.init(entity: entity, insertInto: appDelegate.managedObjectContext)
    self.firstName = firstName
    self.lastName = lastName
  }
  
}
