//
//  ScheduleViewCell.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/16/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit

class ScheduleViewCell: UITableViewCell {
  static let identifier = String(describing: ScheduleViewCell.self)
  
  @IBOutlet weak var lessonType: UILabel!
  @IBOutlet weak var teacher: UILabel!
  @IBOutlet weak var lessonName: UILabel!
  @IBOutlet weak var lessonNumber: UILabel!
}
