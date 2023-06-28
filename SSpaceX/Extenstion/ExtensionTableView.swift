//
//  ExtensionTableView.swift
//  snappTweet
//
//  Created by yahya on 4/22/22.
//

import Foundation
import UIKit
extension UITableView {
    func registerCell(_ name : String) {
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
}
