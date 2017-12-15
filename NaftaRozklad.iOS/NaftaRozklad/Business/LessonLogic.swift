//
//  LessonLogin.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import PromiseKit
import SwiftDate

class LessonLogic {
  static let sharedInstance = LessonLogic()
  
  func initTopCalendarData(for date: Date) -> [Int] {
    var models = [Int]()
    let start = -(date.weekday - 1)
    let end = 7 - date.weekday
    
    for dayOffset in start...end {
      let offsetDate = date + dayOffset.day + 1.day
      models.append(offsetDate.day)
    }
    
    return models
  }
}
