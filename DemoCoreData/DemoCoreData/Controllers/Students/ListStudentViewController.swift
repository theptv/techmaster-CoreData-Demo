//
//  ListStudentViewController.swift
//  DemoCoreData
//
//  Created by Lucio Pham on 11/6/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import UIKit

class ListStudentViewController: UIViewController {
  
  @IBOutlet weak var studentsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBarButton()
    setupTableView()
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
    let addNewStudentVC = AddNewStudentViewController(nibName: "AddNewStudentViewController", bundle: nil)
    navigationController?.pushViewController(addNewStudentVC, animated: true)
  }

}

extension ListStudentViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let studentCell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath) as? StudentTableViewCell else { return UITableViewCell() }
    
    return studentCell
  }
}

extension ListStudentViewController: UITableViewDelegate {
  
}
