//
//  LessonLogin.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import PromiseKit

class LessonLogic {
  static let sharedInstance = LessonLogic()
  
  func initTopCalendarData(for date: Date) -> [String] {
    let calendar = Calendar.current
    var models = [String]()
    
    for dayOffset in -3...3 {
      if let date = calendar.date(byAdding: .day, value: dayOffset, to: date) {
        let day = Formatter.dayFormatter.string(from: date)
        models.append(day)
      }
    }
    
    return models
  }
}
