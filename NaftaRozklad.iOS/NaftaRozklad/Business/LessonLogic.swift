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
  
  func initData(for group: Group) -> Promise<Void> {
    var lessons: Set<Lesson> = []
    
    return WebApi.sharedInstance.getSchedule(for: group, week: .numerator, subgroup: .first).then { days -> Void in
      let weekLessons = Set(Lesson.from(group: group, for: days))
      lessons.formUnion(weekLessons)
    }.then {
      WebApi.sharedInstance.getSchedule(for: group, week: .denumerator, subgroup: .first)
    }.then { days -> Void in
      let weekLessons = Set(Lesson.from(group: group, for: days))
      lessons.formUnion(weekLessons)
    }.then {
      WebApi.sharedInstance.getSchedule(for: group, week: .numerator, subgroup: .second)
    }.then { days -> Void in
      let weekLessons = Set(Lesson.from(group: group, for: days))
      lessons.formUnion(weekLessons)
    }.then {
      WebApi.sharedInstance.getSchedule(for: group, week: .denumerator, subgroup: .second)
    }.then { days -> Void in
      let weekLessons = Set(Lesson.from(group: group, for: days))
      lessons.formUnion(weekLessons)
      
      try? RealmManager.sharedInstance.deleteAll(Lesson.self)
      try? RealmManager.sharedInstance.insert(lessons)
    }
  }
}
