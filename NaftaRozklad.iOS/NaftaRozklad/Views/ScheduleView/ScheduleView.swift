//
//  ScheduleView.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/12/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit
import SwiftDate

struct ScheduleEvent {
  var startDate: DateInRegion
  var endDate: DateInRegion
}

protocol ScheduleViewDataSource {
  func scheduleViewGenerateEvents(_ scheduleView: ScheduleView) -> [ScheduleEvent]
  
  func scheduleView(view for: ScheduleEvent) -> UIView
}

@IBDesignable
class ScheduleView: UIScrollView {
  let timeFrameViewHeight: CGFloat = 60
  let padding: CGFloat = 20
  let circleRadius: CGFloat = 7
  let eventViewTag = 19
  
  var containerView: UIView!
  var currentTimePointerView: UIView!
  var currentTimePointerViewTopConstraint: NSLayoutConstraint!
  
  var dataSource: ScheduleViewDataSource!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  override func prepareForInterfaceBuilder() {
    commonInit()
  }
  
  func commonInit() {
    initContainerView()
    initTimeFrameViews()
    initCurrentTimePointerView()
  }
  
  func initContainerView() {
    containerView = UIView()
    containerView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(containerView)
    
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: topAnchor, constant: timeFrameViewHeight),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.heightAnchor.constraint(equalToConstant: timeFrameViewHeight * 24),
      containerView.widthAnchor.constraint(equalTo: widthAnchor)
      ])
  }
  
  func initTimeFrameViews() {
    for hour in 0...23 {
      initTimeFrameView(for: hour)
      initTimeFrameLabel(for: hour)
    }
  }
  
  func initTimeFrameView(for hour: Int) {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(container)
    
    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: containerView.topAnchor, constant: timeFrameViewHeight * CGFloat(hour)),
      container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
      ])
  }
  
  func initTimeFrameLabel(for hour: Int) {
    let container = containerView.subviews[hour]
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = getLocalizedTime(hour: hour + 1)
    label.font = label.font.withSize(10)
    label.textColor = UIColor.flatGray()
    container.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.bottomAnchor.constraint(equalTo: container.bottomAnchor),
      label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      label.widthAnchor.constraint(equalToConstant: padding + (padding / 2))
      ])
    
    let separatorView = UIView()
    separatorView.translatesAutoresizingMaskIntoConstraints = false
    separatorView.backgroundColor = UIColor.flatGray()
    container.addSubview(separatorView)
    
    NSLayoutConstraint.activate([
      separatorView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5),
      separatorView.heightAnchor.constraint(equalToConstant: 1),
      separatorView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      separatorView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
      ])
  }
  
  func getLocalizedTime(hour: Int) -> String {
    var cmp = DateComponents()
    cmp.hour = hour
    let date = DateInRegion(components: cmp)
    
    guard let str = date?.string(format: .custom("h a")) else {
      return ""
    }
    
    return str
  }
  
  func initCurrentTimePointerView() {
    currentTimePointerView = UIView()
    currentTimePointerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(currentTimePointerView)
    
    NSLayoutConstraint.activate([
      currentTimePointerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding * 2 + (padding / 2)),
      currentTimePointerView.heightAnchor.constraint(equalToConstant: circleRadius),
      currentTimePointerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
      ])
    
    let circleView = UIView()
    circleView.translatesAutoresizingMaskIntoConstraints = false
    currentTimePointerView.addSubview(circleView)
    
    NSLayoutConstraint.activate([
      circleView.widthAnchor.constraint(equalToConstant: circleRadius),
      circleView.heightAnchor.constraint(equalToConstant: circleRadius),
      circleView.topAnchor.constraint(equalTo: currentTimePointerView.topAnchor),
      circleView.leadingAnchor.constraint(equalTo: currentTimePointerView.leadingAnchor)
      ])
    
    circleView.layer.cornerRadius = circleRadius / 2
    circleView.backgroundColor = UIColor.red
    
    let separatorView = UIView()
    separatorView.translatesAutoresizingMaskIntoConstraints = false
    separatorView.backgroundColor = UIColor.red
    currentTimePointerView.addSubview(separatorView)
    
    NSLayoutConstraint.activate([
      separatorView.leadingAnchor.constraint(equalTo: circleView.trailingAnchor),
      separatorView.heightAnchor.constraint(equalToConstant: 1),
      separatorView.trailingAnchor.constraint(equalTo: currentTimePointerView.trailingAnchor),
      separatorView.bottomAnchor.constraint(equalTo: currentTimePointerView.bottomAnchor, constant: -(circleRadius / 2))
      ])
    
    currentTimePointerViewTopConstraint = currentTimePointerView.topAnchor.constraint(equalTo: containerView.topAnchor)
    currentTimePointerViewTopConstraint.isActive = true
    
    // Maybe better to use Timer API?
    DispatchQueue.global(qos: .userInteractive).async {
      while true {
        DispatchQueue.main.async {
          self.refreshCurrentTimePointerView()
        }
        sleep(1)
      }
    }
  }
  
  func getY(for date: DateInRegion) -> CGFloat {
    return CGFloat(date.hour - 1) * timeFrameViewHeight + CGFloat(date.minute)
  }
  
  func refreshCurrentTimePointerView() {
    var position: CGFloat = getY(for: DateInRegion())
    position -= circleRadius / 2
    currentTimePointerViewTopConstraint.constant = position
    layoutIfNeeded()
  }
  
  func reloadData() {
    guard let dataSource = dataSource else {
      return
    }
    
    for view in containerView.subviews {
      for subview in view.subviews {
        if subview.tag == eventViewTag {
          subview.removeFromSuperview()
        }
      }
    }
    
    let events = dataSource.scheduleViewGenerateEvents(self)
    for event in events {
      initEventView(for: event, from: dataSource)
    }
  }
  
  func initEventView(for event: ScheduleEvent, from dataSource: ScheduleViewDataSource) {
    let eventView = dataSource.scheduleView(view: event)
    eventView.tag = eventViewTag
    eventView.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(eventView)
    
    let top = getY(for: event.startDate)
    let height = getY(for: event.endDate) - top
    
    NSLayoutConstraint.activate([
      eventView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: top),
      eventView.heightAnchor.constraint(equalToConstant: height),
      eventView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding * 3),
      eventView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding * 2)
    ])
    
    eventView.backgroundColor = UIColor.randomFlat()
  }
}

