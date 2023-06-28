//
//  InstantiateViewControllerType.swift
//  snappTweet
//
//  Created by yahya on 4/23/22.
//

import Foundation
import UIKit

protocol InstantiateViewControllerType: IdentifiableType {
      static var storyboardName: StoryBoardName { get }
      static func instantiate() -> Self
      static func instantiateNC() -> UINavigationController
}

extension InstantiateViewControllerType {

static func instantiate() -> Self {
    return self.storyboardName.storyboard.instantiateViewController(withIdentifier: self.identifier) as! Self
}

static func instantiateNC() -> UINavigationController {
    return self.storyboardName.storyboard.instantiateViewController(withIdentifier: self.navigationIdentifier) as! UINavigationController
}
}
protocol IdentifiableType {
    static var identifier: String { get }
    static var navigationIdentifier: String { get }
}
extension IdentifiableType {
    static var identifier: String {
        return String(describing: self)
    }
    static var navigationIdentifier: String {
        return "\(self.identifier)NC"
    }
}
