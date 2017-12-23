//
//  RoundView.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/23/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit

@IBDesignable
class RoundView: UIView {

  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = cornerRadius != 0
    }
  }
  
}
