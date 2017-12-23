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
  
  func initData() -> Promise<[GroupViewModel]> {
    if Preferences.sharedInstance.firstLaunch {
      Preferences.sharedInstance.firstLaunch = false
      return refreshData()
    }
    
    if WebApi.sharedInstance.isConnectedToInternet() {
      return refreshData()
    }
    
    guard let allGroups = try? RealmManager.sharedInstance.get(Group.self) else {
      return Promise(value: [GroupViewModel]())
    }
    
    let groups = Array(allGroups)
    return Promise(value: GroupViewModel.from(groups: groups))
  }
  
  func refreshData() -> Promise<[GroupViewModel]> {
    return WebApi.sharedInstance.getGroups().then {
      try? RealmManager.sharedInstance.deleteAll(Group.self)
      try? RealmManager.sharedInstance.insert($0)
      return Promise(value: GroupViewModel.from(groups: $0))
    }
  }
}
