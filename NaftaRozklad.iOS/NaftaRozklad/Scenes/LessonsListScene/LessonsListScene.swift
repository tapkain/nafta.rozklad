//
//  LessonsListScene.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit

class LessonsListScene: UIViewController {
  var topCalendarViewLogic: TopCalendarView!
  @IBOutlet var dayNumberButtons: [UIButton]!
  weak var previousDayNumberButton: UIButton?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initDayNumberButtons()
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
  
  @objc func dayNumberButtonPressed(_ sender: UIButton) {
    if let button = previousDayNumberButton, button != sender {
      button.setCornerRadius(0)
      button.backgroundColor = UIColor.clear
      button.setTitleColor(UIColor.flatWhite(), for: .normal)
      
      sender.makeRound()
      sender.backgroundColor = UIColor.flatWhite()
      sender.setTitleColor(UIColor.flatWatermelon(), for: .normal)
    }
    previousDayNumberButton = sender
  }
}
