//
//  AlertView.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/23/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit

class Alert {
  static let sharedInstance = Alert()
  private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
  
  func showNoInternetConnection(for controller: UIViewController) {
    DispatchQueue.main.async {
      let alertController = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection.", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default)
      alertController.addAction(okAction)
      
      controller.present(alertController, animated: true)
    }
  }
  
  func showActivityIndicator(for controller: UIViewController) {
    controller.view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    activityIndicator.color = UIColor.black
    activityIndicator.frame.origin.x = UIScreen.main.bounds.width / 2 - activityIndicator.frame.width / 2
    activityIndicator.frame.origin.y = UIScreen.main.bounds.height / 2 - 175
  }
  
  func hideActivityIndicator(for controller: UIViewController) {
    activityIndicator.removeFromSuperview()
    activityIndicator.stopAnimating()
  }
}
