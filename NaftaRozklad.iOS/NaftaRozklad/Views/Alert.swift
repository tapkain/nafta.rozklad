//
//  AlertView.swift
//  NaftaRozklad
//
//  Created by Yevhen Velizhenkov on 12/23/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit

class Alert {
  static func showNoInternetConnection(for controller: UIViewController) {
    DispatchQueue.main.async {
      let alertController = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection.", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default)
      alertController.addAction(okAction)
      
      controller.present(alertController, animated: true)
    }
  }
}
