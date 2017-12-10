//
//  Lesson.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import RealmSwift

class Lesson: Object, Codable {
  @objc dynamic var id = 0
  @objc dynamic var group: Group!
  @objc dynamic var period = 0
  
  var day = Day.monday
  var week = Week.common
  var subgroup = Subgroup.common
  
  @objc dynamic var type = ""
  @objc dynamic var name = ""
  @objc dynamic var teacher = ""
}
