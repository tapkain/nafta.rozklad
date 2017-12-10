//
//  Group.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import RealmSwift

class Group: Object, Codable {
  var id = 0
  var name = ""
  var faculty = ""
  var hasSubgroups = false
}
