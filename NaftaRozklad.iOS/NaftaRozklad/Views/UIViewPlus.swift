//
//  UIViewPlus.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/11/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit

extension UIView {
  func setCornerRadius(_ radius: CGFloat) {
    layer.cornerRadius = radius
    layer.masksToBounds = radius != 0
  }
  
  func makeRound() {
    let radius = frame.height / 2
    setCornerRadius(radius)
  }
}
