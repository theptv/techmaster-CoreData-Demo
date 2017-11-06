//
//  AppDelegate.swift
//  DemoCoreData
//
//  Created by Lucio Pham on 11/6/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    appInit()
    createSampleCoreData()
    fetchSampleCoreData()
    
    return true
  }
  
  // MARK: - Setup App Init
  
  fileprivate func createSampleCoreData() {
    let entityDescription = NSEntityDescription.entity(forEntityName: "Student", in: self.managedObjectContext)
    let newStudents = NSManagedObject(entity: entityDescription!, insertInto: managedObjectContext)
    newStudents.setValue("Lucio", forKey: "firstName")
    newStudents.setValue("Lucia", forKey: "lastName")
    
    do {
      try newStudents.managedObjectContext?.save()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  fileprivate func fetchSampleCoreData() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    
    let entityDescription = NSEntityDescription.entity(forEntityName: "Student", in: self.managedObjectContext)
    fetchRequest.entity = entityDescription
    
    do {
      let result = try managedObjectContext.fetch(fetchRequest) as [AnyObject]
      
      for student in result {
        print("First Name: \(student.value(forKey: "firstName")) - Last Name: \(student.value(forKey: "lastName"))")
      }
     
    } catch {
      print(error.localizedDescription)
    }
  }
  
  fileprivate func appInit() {
    window = UIWindow(frame: UIScreen.main.bounds)
    ter
    let studentList = ListStudentViewController(nibName: "ListStudentViewController", bundle: nil)
    let studentNav = UINavigationController(rootViewController: studentList)
    
    window?.rootViewController = studentNav
    window?.makeKeyAndVisible()
  }
  
  // MARK: - Core Data stack
  lazy var applicationDocumentsDirectory: URL = {
    let urls = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
    return urls[urls.count - 1]
  }()
  
  lazy var managedObjectModel: NSManagedObjectModel = {
    let modelURL = Bundle.main.url(forResource: "DataModel", withExtension: "momd")!
    return NSManagedObjectModel(contentsOf: modelURL)!
  }()
  
  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    let url = self.applicationDocumentsDirectory.appendingPathComponent("DataModel.sqlite")
    do {
      try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
    } catch let error {
      print(error)
    }
    return coordinator
  }()
  
  lazy var managedObjectContext: NSManagedObjectContext = {
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
    return managedObjectContext
  }()
  
}

