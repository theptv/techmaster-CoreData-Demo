//
//  ListStudentViewController.swift
//  DemoCoreData
//
//  Created by Lucio Pham on 11/6/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import UIKit
import CoreData

class ListStudentViewController: UIViewController {
  
  @IBOutlet weak var studentsTableView: UITableView!
  
  var students = [Student] ()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBarButton()
    setupTableView()
    fetchStudents()
  }
  
  fileprivate func createStudents() {
    let studentEntity = NSEntityDescription.entity(forEntityName: "Student", in: appDelegate.managedObjectContext)!
    
    let newStudent = Student(studentEntity, firstName: "Lucio", lastName: "Lucia")
    students.append(newStudent)
    saveContext()
  }
  
  fileprivate func fetchStudents() {
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
    do {
      students = try appDelegate.managedObjectContext.fetch(fetchRequest) as! [Student]
      studentsTableView.reloadData()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  fileprivate func delete(_ student: Student) {
    appDelegate.managedObjectContext.delete(student)
    saveContext()
  }
  
  fileprivate func saveContext() {
    do {
      try appDelegate.managedObjectContext.save()
      studentsTableView.reloadData()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  fileprivate func setupTableView() {
    studentsTableView.dataSource = self
    studentsTableView.delegate = self
    
    studentsTableView.register(UINib.init(nibName: "StudentTableViewCell", bundle: nil), forCellReuseIdentifier: "StudentTableViewCell")
  }
  
  fileprivate func setupBarButton() {
    let addNewStudentBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushToAddNewStudent(_:)))
    navigationItem.rightBarButtonItem = addNewStudentBarButtonItem
  }
  
  
  @objc fileprivate func pushToAddNewStudent(_ sender: UIBarButtonItem) {
//    let addNewStudentVC = AddNewStudentViewController(nibName: "AddNewStudentViewController", bundle: nil)
//    navigationController?.pushViewController(addNewStudentVC, animated: true)
    
    createStudents()
  }

}

extension ListStudentViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return students.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let studentCell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath) as? StudentTableViewCell else { return UITableViewCell() }
    
    studentCell.config(students[indexPath.row])
    return studentCell
  }
}

extension ListStudentViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      delete(students[indexPath.row])
      students.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
}
