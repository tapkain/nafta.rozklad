//
//  Lesson.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import RealmSwift

class Lesson: Object, Codable {
  var id = 0
  var group: Group!
  var period = 0
  
  var day = Day.monday
  var week = Week.common
  var subgroup = Subgroup.common
  
  var type = ""
  var name = ""
  var teacher = ""
}
