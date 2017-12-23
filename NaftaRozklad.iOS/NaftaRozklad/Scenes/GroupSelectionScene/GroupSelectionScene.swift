//
//  GroupSelectionScene.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit
import RealmSwift

class GroupSelectionScene: UICollectionViewController {
  var groups = [GroupViewModel]()
  var searchController: UISearchController!
  var refreshControl = UIRefreshControl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tabBarController?.tabBar.items![1].isEnabled = false
    initData()
    initSearchController()
    initPullToRefresh()
  }
  
  func initData() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    GroupLogic.sharedInstance.initData().then { groups -> Void in
      self.groups = groups
      self.collectionView?.reloadData()
    }.always {
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }.catch {_ in
      Alert.showNoInternetConnection(for: self)
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
      let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed(_:)))
      searchButton.tintColor = UIColor.flatWhite()
      navigationItem.rightBarButtonItem = searchButton
      searchController.hidesNavigationBarDuringPresentation = false
    }
  }
  
  func initPullToRefresh() {
    collectionView?.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(refreshGroups(_:)), for: .valueChanged)
  }
}


// MARK: - Actions
extension GroupSelectionScene {
  @objc func searchButtonPressed(_ sender: UIBarButtonItem) {
    present(searchController, animated: true)
  }
  
  @objc func refreshGroups(_ sender: UIRefreshControl) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    GroupLogic.sharedInstance.refreshData().then { groups -> Void in
      self.groups = groups
      self.collectionView?.reloadData()
    }.always {
      self.refreshControl.endRefreshing()
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }.catch {_ in
      Alert.showNoInternetConnection(for: self)
    }
  }
}


// MARK: - UICollectionViewDataSource
extension GroupSelectionScene {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return groups.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupSelectionCell.identifier, for: indexPath) as! GroupSelectionCell
    
    cell.groupName.text = groups[indexPath.row].name
    return cell
  }
}


// MARK: - UICollectionViewFlowDelegate
extension GroupSelectionScene: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width - 30, height: 55)
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    tabBarController?.tabBar.items![1].isEnabled = true
    print("selected item ", groups[indexPath.row].name)
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
    
    groups = GroupViewModel.from(groups: Array(filteredGroups))
    collectionView?.reloadData()
  }
}
