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
  var lessons: [Lesson]!
  
  func initTopCalendarData(for date: DateInRegion) -> [Int] {
    var models = [Int]()
    let start = -(date.weekday - 1)
    let end = 7 - date.weekday
    
    for dayOffset in start...end {
      let offsetDate = date + dayOffset.day + 1.day
      models.append(offsetDate.day)
    }
    
    return models
  }
  
  func initData(for group: Group) -> Promise<Void> {
    lessons = []
    
    return WebApi.sharedInstance.getSchedule(for: group, week: .numerator, subgroup: .first).then { days -> Void in
      self.lessons.append(contentsOf: Lesson.from(group: group, for: days))
    }.then {
      WebApi.sharedInstance.getSchedule(for: group, week: .denumerator, subgroup: .first)
    }.then { days -> Void in
      self.lessons.append(contentsOf: Lesson.from(group: group, for: days))
    }.then {
      WebApi.sharedInstance.getSchedule(for: group, week: .numerator, subgroup: .second)
    }.then { days -> Void in
      self.lessons.append(contentsOf: Lesson.from(group: group, for: days))
    }.then {
      WebApi.sharedInstance.getSchedule(for: group, week: .denumerator, subgroup: .second)
    }.then { days -> Void in
      self.lessons.append(contentsOf: Lesson.from(group: group, for: days))
      
      try? RealmManager.sharedInstance.deleteAll(Lesson.self)
      try? RealmManager.sharedInstance.insert(self.lessons.unique)
    }
  }
  
  func getLessons(for day: Day, week: Week = .common, subgroup: Subgroup = .common) -> [Lesson] {
    guard let lessons = try? RealmManager.sharedInstance.get(Lesson.self).filter("dayValue == %@ && weekValue == %@ && subgroupValue == %@", day.rawValue, week.rawValue, subgroup.rawValue) else {
      return []
    }
    
    return Array(lessons)
  }
}


extension Array where Element: Equatable {
  var unique: [Element] {
    var uniqueValues: [Element] = []
    forEach { item in
      if !uniqueValues.contains(item) {
        uniqueValues += [item]
      }
    }
    return uniqueValues
  }
}
