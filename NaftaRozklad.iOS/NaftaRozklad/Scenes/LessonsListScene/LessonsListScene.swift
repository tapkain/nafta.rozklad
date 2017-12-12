//
//  LessonsListScene.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit
import SwiftDate

class LessonsListScene: UIViewController {
  @IBOutlet var dayNumberButtons: [UIButton]!
  @IBOutlet var scheduleView: UICollectionView!
  
  weak var previousDayNumberButton: UIButton?
  var timeLabels = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initDayNumberButtons()
    //initTimeLabels()
   // initScheduleView()
  }
  
  func initScheduleView() {
    scheduleView.dataSource = self
    scheduleView.delegate = self
    scheduleView.reloadData()
  }
  
  func initDayNumberButtons() {
    let data = LessonLogic.sharedInstance.initTopCalendarData(for: Date())
    
    for i in 0..<data.count {
      let button = dayNumberButtons[i]
      let dayName = data[i]
      button.setTitle(dayName, for: .normal)
      button.addTarget(self, action: #selector(dayNumberButtonPressed(_:)), for: .touchUpInside)
    }
  }
  
  func initTimeLabels() {
    var cmp = DateComponents()
    
    for hour in 1...24 {
      cmp.hour = hour
      let date = DateInRegion(components: cmp)
      if let str = date?.string(format: .custom("h a")) {
        timeLabels.append(str)
      }
    }
  }
  
  @objc func dayNumberButtonPressed(_ sender: UIButton) {
    if let button = previousDayNumberButton, button != sender {
      button.setCornerRadius(0)
      button.backgroundColor = UIColor.clear
      button.setTitleColor(UIColor.flatWhite(), for: .normal)
    }
    
    sender.makeRound()
    sender.backgroundColor = UIColor.flatWhite()
    sender.setTitleColor(UIColor.flatWatermelon(), for: .normal)
    previousDayNumberButton = sender
  }
}


extension LessonsListScene: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.identifier, for: indexPath) as! ScheduleCell
    cell.time.text = timeLabels[indexPath.row]
    cell.clipsToBounds = false
    if indexPath.row != 0 {
      cell.testView.backgroundColor = UIColor.clear
    } else {
      cell.testView.backgroundColor = UIColor.blue
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return timeLabels.count
  }
}


extension LessonsListScene: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 50)
  }
}
