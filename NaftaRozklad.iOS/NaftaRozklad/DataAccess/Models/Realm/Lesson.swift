//
//  Lesson.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import RealmSwift

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
