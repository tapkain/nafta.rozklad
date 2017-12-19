//
//  LessonsListScene.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/10/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit
import SwiftDate

class LessonsListScene: UIViewController {
  weak var scheduleCollectionView: UICollectionView!
  weak var previousDayNumberButton: UIButton?
  
  @IBOutlet var dayNumberButtons: [UIButton]!
  @IBOutlet weak var dayNumbersContainer: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initScheduleCollectionView()
    initDayNumberButtons()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let weekday = Formatter.weekday(for: Date())
    let indexPath = IndexPath(row: weekday, section: 0)
    scheduleCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
  }
  
  func initDayNumberButtons() {
    let today = Date()
    let data = LessonLogic.sharedInstance.initTopCalendarData(for: today)
    
    for i in 0..<data.count {
      let button = dayNumberButtons[i]
      let day = data[i]
      button.setTitle(String(day), for: .normal)
      button.addTarget(self, action: #selector(dayNumberButtonPressed(_:)), for: .touchUpInside)
    }
  }
  
  func initScheduleCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collection = UICollectionView(frame: view.frame,  collectionViewLayout: layout)
    scheduleCollectionView = collection
    scheduleCollectionView.showsHorizontalScrollIndicator = false
    scheduleCollectionView.translatesAutoresizingMaskIntoConstraints = false
    scheduleCollectionView.isPagingEnabled = true
    scheduleCollectionView.backgroundColor = UIColor.white
    view.addSubview(scheduleCollectionView)
    scheduleCollectionView.register(ScheduleViewCell.self, forCellWithReuseIdentifier: ScheduleViewCell.identifier)
    
    NSLayoutConstraint.activate([
      scheduleCollectionView.topAnchor.constraint(equalTo: dayNumbersContainer.topAnchor),
      scheduleCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      scheduleCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scheduleCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    
    scheduleCollectionView.delegate = self
    scheduleCollectionView.dataSource = self
    scheduleCollectionView.reloadData()
  }
  
  @objc func dayNumberButtonPressed(_ sender: UIButton) {
    if let button = previousDayNumberButton, button != sender {
      button.setCornerRadius(0)
      button.backgroundColor = UIColor.clear
      button.setTitleColor(UIColor.flatWhite(), for: .normal)
    }
    
    sender.makeRound()
    sender.backgroundColor = UIColor.flatWhite()
    sender.setTitleColor(UIColor.flatWatermelon(), for: .normal)
    
    if let weekday = dayNumberButtons.index(of: sender) {
      let indexPath = IndexPath(row: weekday, section: 0)
      scheduleCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    previousDayNumberButton = sender
  }
}


extension LessonsListScene: ScheduleViewDataSource {
  func scheduleViewGenerateEvents(_ scheduleView: ScheduleView) -> [ScheduleEvent] {
    let startDate = Date() - 4.hours
    let endDate = Date() - 2.hours + 30.minute
    let event = ScheduleEvent(startDate: startDate, endDate: endDate)
    return [event]
  }
}


extension LessonsListScene: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: scheduleCollectionView.frame.width, height: scheduleCollectionView.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}


extension LessonsListScene: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleViewCell.identifier, for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
}
