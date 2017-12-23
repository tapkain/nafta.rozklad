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
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    initDayNumberButtons()
  }
}


// MARK: - Actions
extension LessonsListScene {
  @objc func dayNumberButtonPressed(_ sender: UIButton) {
    if let index = dayNumberButtons.index(of: sender), sender != previousDayNumberButton {
      let indexPath = IndexPath(row: index, section: 0)
      scheduleCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    changePreviousDayNumberButton(sender)
  }
  
  func changePreviousDayNumberButton(_ sender: UIButton) {
    sender.isSelected = true
    sender.makeRound()
    sender.backgroundColor = UIColor.flatWhite()
    
    if let button = previousDayNumberButton, button != sender {
      button.isSelected = false
      button.setCornerRadius(0)
      button.backgroundColor = UIColor.clear
    }
    
    previousDayNumberButton = sender
  }
}


// MARK: - Initialization
extension LessonsListScene {
  func initDayNumberButtons() {
    dayNumberButtons.sort { $0.tag < $1.tag }
    let today = Date()
    let data = LessonLogic.sharedInstance.initTopCalendarData(for: today)
    
    for i in 0..<data.count {
      let button = dayNumberButtons[i]
      let day = data[i]
      button.setTitle(String(day), for: .normal)
      button.setTitleColor(UIColor.flatWhite(), for: .normal)
      button.setTitleColor(UIColor.flatWatermelon(), for: .selected)
      button.addTarget(self, action: #selector(dayNumberButtonPressed(_:)), for: .touchUpInside)
      button.isExclusiveTouch = true
      
      if i == Formatter.weekday(for: today) {
        button.sendActions(for: .touchUpInside)
      }
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
      scheduleCollectionView.topAnchor.constraint(equalTo: dayNumbersContainer.bottomAnchor),
      scheduleCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      scheduleCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scheduleCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    
    scheduleCollectionView.delegate = self
    scheduleCollectionView.dataSource = self
    scheduleCollectionView.reloadData()
  }
}


// MARK: - ScheduleViewDataSource
extension LessonsListScene: ScheduleViewDataSource {
  func scheduleViewGenerateEvents(_ scheduleView: ScheduleView) -> [ScheduleEvent] {
    let startDate = Date() - 4.hours
    let endDate = Date() - 2.hours + 30.minute
    let event = ScheduleEvent(startDate: startDate, endDate: endDate)
    return [event]
  }
}


// MARK: - UICollectionViewDelegate
extension LessonsListScene: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: scheduleCollectionView.frame.width, height: scheduleCollectionView.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let pageWidth = scrollView.frame.width
    let index = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
    
    let sender = dayNumberButtons[index]
    changePreviousDayNumberButton(sender)
  }
}


// MARK: - UICollectionViewDataSource
extension LessonsListScene: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleViewCell.identifier, for: indexPath) as! ScheduleViewCell
    //cell.scheduleView.dataSource = self
    //cell.scheduleView.reloadData()
    let colors: [UIColor] = [.red, .green, .blue, .yellow, .black, .magenta, .cyan]
    cell.backgroundColor = colors[indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
}
