//
//  LessonDto.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

class LessonDto: Codable {
  var id = 0
  var groupId = 0
  var period = 0
  
  var day = Day.monday
  var week = Week.common
  var subgroup = Subgroup.common
  
  var type = ""
  var name = ""
  var teacher = ""
}
