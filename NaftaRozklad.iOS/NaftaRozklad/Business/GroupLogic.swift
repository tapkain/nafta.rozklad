//
//  GroupLogic.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import PromiseKit

class GroupLogic {
  static let sharedInstance = GroupLogic()
  
  func initData() -> Promise<[Group]> {
    if Preferences.sharedInstance.firstLaunch {
      Preferences.sharedInstance.firstLaunch = false
      return WebApi.sharedInstance.getGroups().then {
        try! RealmManager.sharedInstance.insert($0)
        return Promise(value: $0)
      }
    }
    
    if WebApi.sharedInstance.isConnectedToInternet() {
      try! RealmManager.sharedInstance.deleteAll(Group.self)
      return WebApi.sharedInstance.getGroups().then {
        try! RealmManager.sharedInstance.insert($0)
        return Promise(value: $0)
      }
    }
    
    let groups = Array(try! RealmManager.sharedInstance.get(Group.self))
    return Promise(value: groups)
  }
}
