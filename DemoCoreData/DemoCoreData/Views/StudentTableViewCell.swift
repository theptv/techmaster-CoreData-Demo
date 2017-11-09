//
//  StudentTableViewCell.swift
//  DemoCoreData
//
//  Created by Lucio Pham on 11/6/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
  
  @IBOutlet weak var studentNameLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  public func config(_ student: Student) {
    studentNameLabel.text = "\(student.lastName!) \(student.firstName!)"
  }
  
}
