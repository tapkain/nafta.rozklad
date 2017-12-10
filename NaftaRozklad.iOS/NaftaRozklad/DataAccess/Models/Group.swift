//
//  Group.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import RealmSwift

class Group: Object, Codable {
  @objc dynamic var id = ""
  @objc dynamic var faculty = ""
  @objc dynamic var name = ""
  @objc dynamic var hasSubgroups = false
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case faculty
    case hasSubgroups = "has_subgroups"
  }
}
