//
//  AlertView.swift
//  NewsApi
//
//  Created by Lawencon on 28/08/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import UIKit

class AlertView: NSObject {
    class func showAlert(view: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true)
    }
}
