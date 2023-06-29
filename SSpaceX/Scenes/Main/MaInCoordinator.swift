//
//  MaInCoordinator.swift
//  SSpaceX
//
//  Created by yahya on 6/27/23.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinatable {
    var rootViewController: UIViewController
      init(with _window: UIWindow) {
          let nc = MainViewController.instantiateNC()
          let vc = nc.viewControllers.first as! MainViewController
          self.rootViewController = nc
          let viewModel = MainViewModel()
          vc.viewModel = viewModel
          viewModel.coordinator = self
          viewModel.delegate = vc
      }
  func showDetails(_ model: MissionModel) {
      
      DetailsMissionCoordinator.init(mission: model).coordinate(to: rootViewController)
  }
  
  
  
}
