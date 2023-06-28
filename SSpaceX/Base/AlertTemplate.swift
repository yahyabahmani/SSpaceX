//
//  AlertTemplate.swift
//  snappTweet
//
//  Created by yahya on 4/23/22.
//

import UIKit

class AlertTemplate: NSObject {
class func ShowAlert(title:String = "", message :String = "", vc:UIViewController, action: ((UIAlertAction) -> Void)? = nil) {
  let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

  let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: action)
  alert.addAction(okAction)
  OperationQueue.main.addOperation {
      vc.present(alert, animated: true, completion: nil)
  }
}
}
