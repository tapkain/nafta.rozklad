//
//  Preferences.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import Foundation
import SwiftDate

class Preferences {
  struct LessonFilter {
    var week: Week
    var subgroup: Subgroup
  }
  
  static let sharedInstance = Preferences()
  let userDefaults = UserDefaults.standard
  
  // TODO: maybe change this logic
  var firstLaunch: Bool {
    get {
      return !userDefaults.bool(forKey: "isNotFirstLaunch")
    }
    
    set {
      userDefaults.set(!newValue, forKey: "isNotFirstLaunch")
    }
  }
  
  var lessonFilter: LessonFilter {
    get {
      let today = DateInRegion()
      let week = Week(rawValue: today.weekOfYear % 2) ?? .numerator
      let subgroup = Subgroup(rawValue: userDefaults.integer(forKey: "currentSubgroup")) ?? .first
      return LessonFilter(week: week, subgroup: subgroup)
    }
    
    set {
      userDefaults.set(newValue.subgroup.rawValue, forKey: "currentSubgroup")
    }
  }
}
