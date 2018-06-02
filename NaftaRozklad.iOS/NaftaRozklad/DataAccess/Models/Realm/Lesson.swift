//
//  Lesson.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import RealmSwift
import SwiftDate

class Lesson: Object, Codable {
  @objc dynamic var group: Group!
  @objc dynamic var period = 0
  
  @objc dynamic var dayValue = Day.monday.rawValue
  @objc dynamic var weekValue = Week.common.rawValue
  @objc dynamic var subgroupValue = Subgroup.common.rawValue
  
  var day: Day {
    get { return Day(rawValue: dayValue)! }
    set { dayValue = newValue.rawValue }
  }
  
  var week: Week {
    get { return Week(rawValue: weekValue)! }
    set { weekValue = newValue.rawValue }
  }
  
  var subgroup: Subgroup {
    get { return Subgroup(rawValue: subgroupValue)! }
    set { subgroupValue = newValue.rawValue }
  }
  
  @objc dynamic var type: String? = nil
  @objc dynamic var name = ""
  @objc dynamic var teacher: String? = nil
}


extension Lesson {
  static func == (lhs: Lesson, rhs: Lesson) -> Bool {
    return lhs.day == rhs.day
  }
}
//// MARK: - Hashable
//extension Lesson {
//  override var hashValue: Int {
//    return
////      group.hashValue ^
////      period.hashValue ^
//      day.hashValue// ^
////      week.hashValue ^
////      subgroup.hashValue ^
////      (type?.hashValue ?? 0) ^
////      name.hashValue ^
////      (teacher?.hashValue ?? 0)
//  }
//}


// MARK: - DayDto Convert
extension Lesson {
  static func from(group: Group, for days: [DayDto]) -> [Lesson] {
    var lessons = [Lesson]()
    for day in days {
      lessons.append(contentsOf: Lesson.from(group: group, for: day))
    }
    return lessons
  }
  
  static func from(group: Group, for day: DayDto) -> [Lesson] {
    return day.lessons.flatMap {
      Lesson.from(group: group, and: $0, for: day.day)
    }
  }
  
  static func from(group: Group, and lessonDto: LessonDto, for day: Int) -> Lesson {
    let lesson = Lesson()
    lesson.group = group
    
    if let period = Int(lessonDto.period) {
      lesson.period = period
    }
    
    lesson.dayValue = day
    
    if let week = Int(lessonDto.week) {
      lesson.weekValue = week
    }
    
    if let subgroup = Int(lessonDto.subgroup) {
      lesson.subgroupValue = subgroup
    }
    
    lesson.type = lessonDto.type
    lesson.teacher = lessonDto.teacher
    lesson.name = lessonDto.name
    
    return lesson
  }
}


// MARK: ScheduleEvent Convert
extension Lesson {
  static let lessonHours: [Int: [DateComponents]] = [
    1: [DateComponents(hour: 8, minute: 0), DateComponents(hour: 9, minute: 20)],
    2: [DateComponents(hour: 9, minute: 35), DateComponents(hour: 10, minute: 55)],
    3: [DateComponents(hour: 11, minute: 10), DateComponents(hour: 12, minute: 30)],
    4: [DateComponents(hour: 13, minute: 0), DateComponents(hour: 14, minute: 20)],
    5: [DateComponents(hour: 14, minute: 35), DateComponents(hour: 16, minute: 0)],
    6: [DateComponents(hour: 16, minute: 15), DateComponents(hour: 17, minute: 30)]
  ]
  
  func toScheduleEvent() -> ScheduleEvent {
    let today = DateInRegion()
    var cmp = DateComponents()
    cmp.year = today.year
    cmp.month = today.month
    cmp.day = today.day - (today.weekday - day.rawValue)
    
    cmp.hour = Lesson.lessonHours[period]![0].hour
    cmp.minute = Lesson.lessonHours[period]![0].minute
    let startDate = DateInRegion(components: cmp)
    
    cmp.hour = Lesson.lessonHours[period]![1].hour
    cmp.minute = Lesson.lessonHours[period]![1].minute
    let endDate = DateInRegion(components: cmp)
    
    return ScheduleEvent(startDate: startDate!, endDate: endDate!)
  }
}
