//
//  ViewController.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 10/4/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UITableViewController {
  let realm = try! Realm()
  lazy var groups: Results<UniversityGroup> = { realm.objects(UniversityGroup.self) }()
  let cellIdentifier = LoginTableViewCell.identifier
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchGroups()
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LoginTableViewCell
    let group = groups[indexPath.row]
    cell.groupNameLabel?.text = group.name
    
    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return groups.count
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func fetchGroups() {
    ApiManager.sharedInstance.getUniversityGroups { groups in
      self.realm.deleteAll()
      
      try! self.realm.write() {
        for group in groups {
          self.realm.add(group)
        }
      }
      
      self.groups = self.realm.objects(UniversityGroup.self)
      self.tableView.reloadData()
    }
  }
}

