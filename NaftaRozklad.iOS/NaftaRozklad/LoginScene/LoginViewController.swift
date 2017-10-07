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
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let groupName = groups[indexPath.row].name
    let alertController = UIAlertController(title: "Do you really want to choose " + groupName, message: nil, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "NO", style: .cancel)
    let okAction = UIAlertAction(title: "YES", style: .default) { action in
      //present VC here
    }
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return groups.count
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func fetchGroups() {
    ApiManager.sharedInstance.getUniversityGroups { groups in
      try! self.realm.write() {
        let groupsToDelete = self.realm.objects(UniversityGroup.self)
        self.realm.delete(groupsToDelete)

        
        for group in groups {
          self.realm.add(group)
        }
      }
      
      self.groups = self.realm.objects(UniversityGroup.self)
      
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
}

