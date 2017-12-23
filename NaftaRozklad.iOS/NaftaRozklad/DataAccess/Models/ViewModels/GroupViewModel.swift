//
//  GroupViewModel.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/23/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import Foundation

struct GroupViewModel {
  var name: String
}

extension GroupViewModel {
  static func from(group: Group) -> GroupViewModel {
    return GroupViewModel(name: group.name)
  }
  
  static func from(groups: [Group]) -> [GroupViewModel] {
    return groups.flatMap {
      return from(group: $0)
    }
  }
}
