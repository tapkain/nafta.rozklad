//
//  ScheduleHoursCellTableViewCell.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/12/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit

class ScheduleCell: UICollectionViewCell {
  static let identifier = String(describing: ScheduleCell.self)
  
  @IBOutlet var time: UILabel!
  @IBOutlet weak var testView: UIView!
}
