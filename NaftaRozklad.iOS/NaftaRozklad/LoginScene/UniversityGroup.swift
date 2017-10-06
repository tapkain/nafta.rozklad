//
//  UniversityGroup.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 10/4/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class UniversityGroup: Object {
  @objc dynamic var name = ""
}

// MARK - Json
extension UniversityGroup {
  static func fromJson(_ json: JSON) -> UniversityGroup {
    let group = UniversityGroup()
    group.name = json["name"].string!
    return group
  }
}
