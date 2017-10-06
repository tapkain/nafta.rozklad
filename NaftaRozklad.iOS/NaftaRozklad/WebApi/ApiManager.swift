//
//  ApiManager.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 10/6/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ApiManager {
  static let sharedInstance = ApiManager()
  
  func getUniversityGroups(completion: @escaping ([UniversityGroup]) -> Void) {
    Alamofire.request(ApiManager.baseURL + ApiManager.groups).responseString { response in
      switch response.result {
        
      case .success(let value):
        let json = JSON(parseJSON: value)
        var groups: [UniversityGroup] = []
        
        for (_, subJson) in json {
          groups.append(UniversityGroup.fromJson(subJson))
        }
        completion(groups)
        
      case .failure(let error):
        print(error)
      }
    }
  }
}

// MARK - API Endpoints
extension ApiManager {
  static let baseURL = "http://rozklad.nung.edu.ua/application/"
  static let groups = "api/groups.php"
}
