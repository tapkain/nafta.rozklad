//
//  Formatter.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import Foundation
import SwiftDate

class Formatter {
  
  // Sunday is the first weekday, this returns
  // it as last weekday
  static func weekday(for date: DateInRegion) -> Int {
    let weekday = date.weekday - 2
    return weekday >= 0 ? weekday : 7
  }
}
