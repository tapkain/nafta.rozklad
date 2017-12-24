//
//  LessonDto.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

struct LessonDto: Codable {
  let period: String
  
  let week: String
  let subgroup: String
  
  let type: String?
  let name: String
  let teacher: String?
  let room: String?
}
