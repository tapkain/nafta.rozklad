//
//  WebApi.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import Alamofire
import PromiseKit

class WebApi {
  static let sharedInstance = WebApi()
  let baseUrl = "http://rozklad.nung.edu.ua/application"
  
  func getGroups() -> Promise<[Group]> {
    let url = "\(baseUrl)/api/groups.php"
    
    return Alamofire.request(url, method: .get).validate().responseData().then {
      guard let groups = try? JSONDecoder().decode([Group].self, from: $0) else {
        return Promise(value: [Group]())
      }
      return Promise(value: groups)
    }
  }
  
  func getSchedule(for group: Group, week: Week, subgroup: Subgroup) -> Promise<[DayDto]> {
    let url = "\(baseUrl)/api/schedules.php"
    let parameters: Parameters = ["group_id": group.id, "week": week, "subgroup": subgroup]
    
    return Alamofire.request(url, method: .get, parameters: parameters).validate().responseData().then {
      guard let days = try? JSONDecoder().decode([DayDto].self, from: $0) else {
        return Promise(value: [DayDto]())
      }
      return Promise(value: days)
    }
  }
  
  class func isConnectedToInternet() -> Bool {
    return NetworkReachabilityManager()!.isReachable
  }
}
