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
  weak var previousDayNumberButton: UIButton?
  var currentVisibleDay: Day? {
    didSet {
      lessons = LessonLogic.sharedInstance.getLessons(for: currentVisibleDay!)
    }
  }
  
  var lessons = [Lesson]()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet var dayNumberButtons: [UIButton]!
  @IBOutlet weak var dayNumbersContainer: UIView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.reloadData()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    tableView.delegate = nil
    tableView.dataSource = nil
    lessons = [Lesson]()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    initDayNumberButtons()
  }
}


// MARK: - Actions
extension LessonsListScene {
  @objc func dayNumberButtonPressed(_ sender: UIButton) {
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
    
    if let index = dayNumberButtons.index(of: sender) {
      currentVisibleDay = Day(rawValue: index + 1)
      tableView.reloadData()
    }
    
    previousDayNumberButton = sender
  }
}


// MARK: - Initialization
extension LessonsListScene {
  func initDayNumberButtons() {
    dayNumberButtons.sort { $0.tag < $1.tag }
    let today = DateInRegion()
    let data = LessonLogic.sharedInstance.initTopCalendarData(for: today)
    
    for i in 0..<data.count {
      let button = dayNumberButtons[i]
      let day = data[i]
      button.setTitle(String(day), for: .normal)
      button.setTitleColor(UIColor.flatWhite(), for: .normal)
      button.setTitleColor(UIColor.flatWatermelon(), for: .selected)
      button.addTarget(self, action: #selector(dayNumberButtonPressed(_:)), for: .touchUpInside)
      button.isExclusiveTouch = true
      
      let weekday = Formatter.weekday(for: today) - 1
      if i == weekday {
        button.sendActions(for: .touchUpInside)
      }
    }
  }
}


// MARK: - UITableViewDataSource
extension LessonsListScene: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return lessons.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: ScheduleViewCell.identifier, for: indexPath)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let lesson = lessons[indexPath.row]
    guard let cell = cell as? ScheduleViewCell else {
      return
    }
    cell.lessonName.text = lesson.name
    cell.lessonNumber.text = String(lesson.period)
    cell.lessonType.text = lesson.type
    cell.teacher.text = lesson.teacher
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 108
  }
}
