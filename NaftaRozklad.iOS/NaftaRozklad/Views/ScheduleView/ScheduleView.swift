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
  var startDate: Date
  var endDate: Date
}

protocol ScheduleViewDataSource {
  func scheduleViewGenerateEvents(_ scheduleView: ScheduleView) -> [ScheduleEvent]
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
    
    containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    containerView.heightAnchor.constraint(equalToConstant: timeFrameViewHeight * 25).isActive = true
    containerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
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
    
    container.topAnchor.constraint(equalTo: containerView.topAnchor, constant: timeFrameViewHeight * CGFloat(hour)).isActive = true
    container.heightAnchor.constraint(equalToConstant: timeFrameViewHeight).isActive = true
    container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding).isActive = true
    container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding).isActive = true
  }
  
  func initTimeFrameLabel(for hour: Int) {
    let container = containerView.subviews[hour]
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = getLocalizedTime(hour: hour + 1)
    label.font = label.font.withSize(10)
    label.textColor = UIColor.flatGray()
    container.addSubview(label)
    
    label.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    label.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
    label.widthAnchor.constraint(equalToConstant: padding + (padding / 2)).isActive = true
    
    let separatorView = UIView()
    separatorView.translatesAutoresizingMaskIntoConstraints = false
    separatorView.backgroundColor = UIColor.flatGray()
    container.addSubview(separatorView)
    
    separatorView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
    separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    separatorView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
    separatorView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
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
    
    currentTimePointerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding * 2 + (padding / 2)).isActive = true
    currentTimePointerView.heightAnchor.constraint(equalToConstant: circleRadius).isActive = true
    currentTimePointerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding).isActive = true
    
    let circleView = UIView()
    circleView.translatesAutoresizingMaskIntoConstraints = false
    currentTimePointerView.addSubview(circleView)
    
    circleView.widthAnchor.constraint(equalToConstant: circleRadius).isActive = true
    circleView.heightAnchor.constraint(equalToConstant: circleRadius).isActive = true
    circleView.topAnchor.constraint(equalTo: currentTimePointerView.topAnchor).isActive = true
    circleView.leadingAnchor.constraint(equalTo: currentTimePointerView.leadingAnchor).isActive = true
    circleView.layer.cornerRadius = circleRadius / 2
    circleView.backgroundColor = UIColor.red
    
    let separatorView = UIView()
    separatorView.translatesAutoresizingMaskIntoConstraints = false
    separatorView.backgroundColor = UIColor.red
    currentTimePointerView.addSubview(separatorView)
    
    separatorView.leadingAnchor.constraint(equalTo: circleView.trailingAnchor).isActive = true
    separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    separatorView.trailingAnchor.constraint(equalTo: currentTimePointerView.trailingAnchor).isActive = true
    separatorView.bottomAnchor.constraint(equalTo: currentTimePointerView.bottomAnchor, constant: -(circleRadius / 2)).isActive = true
    currentTimePointerViewTopConstraint = currentTimePointerView.topAnchor.constraint(equalTo: containerView.topAnchor)
    currentTimePointerViewTopConstraint.isActive = true
    
    DispatchQueue.global(qos: .userInteractive).async {
      while true {
        DispatchQueue.main.async {
          self.refreshCurrentTimePointerView()
        }
        sleep(1)
      }
    }
  }
  
  func getY(for date: Date) -> CGFloat {
    return CGFloat(date.hour) * timeFrameViewHeight + CGFloat(date.minute)
  }
  
  func refreshCurrentTimePointerView() {
    var position: CGFloat = getY(for: Date())
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
      initEventView(for: event)
    }
  }
  
  func initEventView(for event: ScheduleEvent) {
    let eventView = UIView()
    eventView.tag = eventViewTag
    eventView.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(eventView)
    
    let top = getY(for: event.startDate)
    let height = getY(for: event.endDate) - top
    eventView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: top).isActive = true
    eventView.heightAnchor.constraint(equalToConstant: height).isActive = true
    eventView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding * 3).isActive = true
    eventView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding * 2).isActive = true
    
    eventView.backgroundColor = UIColor.randomFlat()
  }
}
