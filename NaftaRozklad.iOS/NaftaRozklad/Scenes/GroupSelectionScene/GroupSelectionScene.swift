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
      self.collectionView?.reloadData()
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
      let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed(_:)))
      searchButton.tintColor = UIColor.flatWhite()
      navigationItem.rightBarButtonItem = searchButton
      searchController.hidesNavigationBarDuringPresentation = false
    }
  }
}


// MARK: - Actions
extension GroupSelectionScene {
  @objc func searchButtonPressed(_ sender: UIBarButtonItem) {
    present(searchController, animated: true)
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
    
    groups = Array(filteredGroups)
    collectionView?.reloadData()
  }
}
