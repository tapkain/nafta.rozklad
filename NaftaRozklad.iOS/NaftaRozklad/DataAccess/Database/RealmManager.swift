//
//  RealmManager.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import RealmSwift

class RealmManager {
  static let sharedInstance = RealmManager()
  
  func insert<Model: Object>(_ model: Model) throws {
    try insert([model])
  }
  
  func insert<Model: Object>(_ models: [Model]) throws {
    let realm = try Realm()
    
    try realm.write {
      realm.add(models)
    }
  }
  
  func get<Model: Object>(_ modelType: Model.Type) throws -> Results<Model> {
    let realm = try Realm()
    return realm.objects(modelType)
  }
  
  func deleteAll<Model: Object>(_ modelType: Model.Type) throws {
    let realm = try Realm()
    
    try realm.write {
      let allObjects = realm.objects(modelType)
      realm.delete(allObjects)
    }
  }
}
