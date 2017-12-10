//
//  Preferences.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import Foundation

class Preferences {
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
}
