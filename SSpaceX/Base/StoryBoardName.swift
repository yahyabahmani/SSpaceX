//
//  StoryBoardName.swift
//  snappTweet
//
//  Created by yahya on 2/23/22.
//

import Foundation
import UIKit
enum StoryBoardName: String {
    case main = "Main"
    case details = "DetailsMission"
    var storyboard: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
