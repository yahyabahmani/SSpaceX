//
//  DetailsMissionCoordinator.swift
//  SSpaceX
//
//  Created by yahya on 6/28/23.
//

import Foundation
import UIKit
final class DetailsMissionCoordinator: Coordinatable {
  var rootViewController: UIViewController
  init(mission:MissionModel) {
      let vc = DetailsMissionController.instantiate()
      self.rootViewController = vc
      let viewModel = DetailsMissionViewModel(mission: mission)
      vc.viewModel = viewModel
  }
}
