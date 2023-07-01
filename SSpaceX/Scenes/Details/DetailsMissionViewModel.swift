//
//  DetailsMissionViewModel.swift
//  SSpaceX
//
//  Created by Jabama on 6/28/23.
//

import Foundation

final class DetailsMissionViewModel: BaseViewModel {
   private var mission: MissionModel
    var dataSource = [CellType]()
    var bookmarkImage = ""
    var reload: ((Int) -> ())?
    init(mission: MissionModel) {
    self.mission = mission
  }
    func createCell(){
       if let url = self.mission.smallPatch {
           self.dataSource.append(.image(url: url, id: self.bookmarkImage))
        }
        if var title = self.mission.name {
            title = "Name :\(title)"
            self.dataSource.append(.title(title: title))
        }
        if var flightNumber = self.mission.flightNumber {
            flightNumber = "Flight Number :\(flightNumber)"
            self.dataSource.append(.title(title: flightNumber))
        }
        if let date = self.mission.dateUTC{
            self.dataSource.append(.title(title: date))
        }
        if var details = self.mission.details {
            details = "Details \(details)"
            self.dataSource.append(.title(title: details))
        }
        if let wikipedia = self.mission.wikipedia{
            self.dataSource.append(.wikipedia(link: wikipedia))
        }
        
    }
    func initialCell(){
            self.checkBookMark { result in
                self.bookmarkImage = result ? BookmarkStatus.enable.rawValue :  BookmarkStatus.disable.rawValue
                self.createCell()
            }
    }
    func checkBookMark(completion:@escaping (Bool)->()){
        guard let id = self.mission.id else{return }
        BookmarkDB.shared.checkID(id: id) { result in
            completion(result)
        } errorCompletion: { error in
            self.errorWithDismissViewController(message: error?.localizedDescription ?? "")
            completion(false)
        }
    }
    func selectBookmark(){
        
        self.checkBookMark { result in
            if result { // bool
                self.removeItemDB()
                self.bookmarkImage = BookmarkStatus.disable.rawValue //false
            }else{
                self.addItemDB()
                self.bookmarkImage = BookmarkStatus.enable.rawValue // true
            }
            self.updateImageRow()
        }
    
     
        
    }
    func removeItemDB(){
        guard let id = self.mission.id else{return }
        BookmarkDB.shared.deleteItem(id: id) { error in
            if error != nil{
                self.errorWithDismissViewController(message: error?.localizedDescription ?? "")

            }
        }
    }
    func addItemDB(){
        guard let id = self.mission.id else{return }
        BookmarkDB.shared.createItem(id: id) { error in
            if error != nil{
                self.errorWithDismissViewController(message: error?.localizedDescription ?? "")

            }
        }
    }
    func updateImageRow(){
        var image = ""
        let index =   self.dataSource.firstIndex { item in
              switch  item{
              case .image(let img,_):
                  image = img
                  return true
              default :
                  return false
                  
              }
          }
        if let index = index {
            self.dataSource[index] = .image(url: image, id: self.bookmarkImage)
            self.reload?(index)
        }
          
    }
    enum BookmarkStatus:String {
    case enable = "bookmark.fill"
    case disable = "bookmark"
    }
    
    enum CellType {
        case image(url:String,id:String)
        case title(title:String)
        case wikipedia(link:String)
    }
}
