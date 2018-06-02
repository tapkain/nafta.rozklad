//
//  GroupViewModel.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/23/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import Foundation

struct GroupViewModel {
  var id: String
  var name: String
}

extension GroupViewModel {
  static func from(group: Group) -> GroupViewModel {
    return GroupViewModel(id: group.id, name: group.name)
  }
  
  static func from(groups: [Group]) -> [GroupViewModel] {
    return groups.map {
      return from(group: $0)
    }
  }
}
