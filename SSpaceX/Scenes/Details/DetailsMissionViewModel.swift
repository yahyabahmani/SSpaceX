//
//  DetailsMissionViewModel.swift
//  SSpaceX
//
//  Created by Jabama on 6/28/23.
//

import Foundation

final class DetailsMissionViewModel {
   private var mission: MissionModel
    var dataSource = [CellType]()
    
    init(mission: MissionModel) {
    self.mission = mission
        self.createCell()
  }
   private func createCell(){
        if let url = self.mission.largePatch {
            self.dataSource.append(.image(url: url))
        }
        if let title = self.mission.name {
            self.dataSource.append(.title(title: title))
        }
        if let date = self.mission.dateUTC{
            self.dataSource.append(.title(title: date))
        }
        if let details = self.mission.details {
            self.dataSource.append(.title(title: details))
        }
        if let wikipedia = self.mission.wikipedia{
            self.dataSource.append(.wikipedia(link: wikipedia))
        }
        
    }
    enum CellType {
        case image(url:String)
        case title(title:String)
        case wikipedia(link:String)
    }
}
