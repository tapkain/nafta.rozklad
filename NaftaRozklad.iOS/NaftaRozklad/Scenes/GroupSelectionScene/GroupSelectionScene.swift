//
//  GroupSelectionScene.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit
import RealmSwift

class GroupSelectionScene: UITableViewController {
  var groups = [Group]()
  var searchController: UISearchController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initData()
    initSearchController()
  }
  
  func initData() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    GroupLogic.sharedInstance.initData().then { groups -> Void in
      self.groups = groups
      self.tableView.reloadData()
    }.always {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }.catch {
        print($0)
    }
  }
  
  func initSearchController() {
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    
    if #available(iOS 11.0, *) {
      navigationItem.searchController = searchController
      navigationItem.hidesSearchBarWhenScrolling = false
    } else {
      tableView.tableHeaderView = searchController.searchBar
    }
  }
}


// MARK: - UITableViewDataSource
extension GroupSelectionScene {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return groups.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GroupSelectionCell.identifier, for: indexPath) as! GroupSelectionCell
    
    cell.groupName.text = groups[indexPath.row].name
    return cell
  }
}


// MARK: - UITableViewDelegate
extension GroupSelectionScene {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Selected item at ", indexPath.row)
  }
}


// MARK: - UISearchResultsUpdating
extension GroupSelectionScene: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    var filteredGroups: Results<Group>!
    
    if let searchText = searchController.searchBar.text, searchText.count != 0 {
      filteredGroups =  try! RealmManager.sharedInstance.get(Group.self).filter("name CONTAINS[cd] %@", searchText)
    } else {
      filteredGroups = try! RealmManager.sharedInstance.get(Group.self)
    }
    
    groups = Array(filteredGroups)
    tableView.reloadData()
  }
}
