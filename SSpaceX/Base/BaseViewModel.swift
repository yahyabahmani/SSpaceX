//
//  BaseViewModel.swift
//  snappTweet
//
//  Created by yahya on 4/23/22.
//

import Foundation
import UIKit

class BaseViewModel {
    weak var delegate: BaseViewModelDelegate?
    var coordinator: Coordinatable?
    func errorWithDismissViewController(message: String) {
        self.delegate?.showErrorMessageDismiss(message)
    }
}

protocol BaseViewModelDelegate: NSObjectProtocol {
    func showErrorMessageDismiss(_ message: String)
}

extension UIViewController: BaseViewModelDelegate {
    func showErrorMessageDismiss(_ message: String) {
      AlertTemplate.ShowAlert( message: message, vc: self) { (_) in
                 self.dismiss(animated: true, completion: nil)
             }
    }

}
