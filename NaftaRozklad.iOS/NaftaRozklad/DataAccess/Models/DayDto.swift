//
//  DayDto.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

class DayDto: Codable {
  var lessons: [LessonDto]!
  var day = Day.monday
}
