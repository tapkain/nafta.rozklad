//
//  TopCalendarView.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit

class TopCalendarView: NSObject {
  var dayNumbers: [String]!
  
  init(collectionView: UICollectionView) {
    super.init()
    collectionView.delegate = self
    collectionView.dataSource = self
    dayNumbers = LessonLogic.sharedInstance.initTopCalendarData(for: Date())
  }
}


extension TopCalendarView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCalendarCell.identifier, for: indexPath) as! TopCalendarCell
    
    cell.dayNumber.text = dayNumbers[indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
}


extension TopCalendarView: UICollectionViewDelegate {
  
}
