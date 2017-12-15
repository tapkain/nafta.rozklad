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
  @IBOutlet var scheduleView: ScheduleView!
  
  weak var previousDayNumberButton: UIButton?
  var timeLabels = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initDayNumberButtons()
    initScheduleView()
  }
  
  func initScheduleView() {
    scheduleView.dataSource = self
    scheduleView.reloadData()
  }
  
  func initDayNumberButtons() {
    let today = Date()
    let data = LessonLogic.sharedInstance.initTopCalendarData(for: today)
    
    for i in 0..<data.count {
      let button = dayNumberButtons[i]
      let day = data[i]
      button.setTitle(String(day), for: .normal)
      button.addTarget(self, action: #selector(dayNumberButtonPressed(_:)), for: .touchUpInside)
      
      if day == today.day {
        button.sendActions(for: .touchUpInside)
      }
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
  
  @IBAction func scheduleViewSwiped(_ sender: UISwipeGestureRecognizer) {
    if sender.direction == .right {
      print("right")
    }
    
    if sender.direction == .left {
      print("left")
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


extension LessonsListScene: ScheduleViewDataSource {
  func scheduleViewGenerateEvents(_ scheduleView: ScheduleView) -> [ScheduleEvent] {
    let startDate = Date() - 4.hours
    let endDate = Date() - 2.hours + 30.minute
    let event = ScheduleEvent(startDate: startDate, endDate: endDate)
    return [event]
  }
}
