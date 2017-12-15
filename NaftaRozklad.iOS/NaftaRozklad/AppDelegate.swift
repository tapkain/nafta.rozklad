//
//  AppDelegate.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 10/4/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit
import ChameleonFramework
import SwiftDate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let ukraineRegion = Region(tz: TimeZoneName.europeKiev, cal: CalendarName.gregorian, loc: LocaleName.ukrainianUkraine)
    Date.setDefaultRegion(ukraineRegion)
    return true
  }
}

