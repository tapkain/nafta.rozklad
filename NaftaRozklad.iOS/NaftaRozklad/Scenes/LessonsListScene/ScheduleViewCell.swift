//
//  ScheduleViewCell.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/16/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit

class ScheduleViewCell: UICollectionViewCell {
  static let identifier = String(describing: ScheduleViewCell.self)
  var scheduleView: ScheduleView!
  
  override func prepareForReuse() {
    scheduleView.delegate = nil
    scheduleView.dataSource = nil
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit() {
    let scheduleView = ScheduleView()
    self.scheduleView = scheduleView
    scheduleView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(scheduleView)
    
    NSLayoutConstraint.activate([
      scheduleView.topAnchor.constraint(equalTo: topAnchor),
      scheduleView.bottomAnchor.constraint(equalTo: bottomAnchor),
      scheduleView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scheduleView.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
  }
}
