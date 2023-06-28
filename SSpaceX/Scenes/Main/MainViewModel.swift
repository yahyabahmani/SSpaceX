//
//  MainViewModel.swift
//  SSpaceX
//
//  Created by yahya on 6/27/23.
//

import Foundation
import Combine
final class MainViewModel: BaseViewModel {
    var reloadRows: (([IndexPath]) -> ())?
    let missions = CurrentValueSubject<[MissionModel], Never>([MissionModel]())
    var subsciptions = Set<AnyCancellable>()
    let membershipRepository = MembershipRepository()
    var isLastPage = false
    private var total: Int = 1
    private var pageNumber: Int = 0
    var isLoading = false
    
    
    func showDetails(_ text: String) {
        (self.coordinator as? MainCoordinator)?.showShareList(text)
    }
    

    
    func fetchData(){
        guard self.missions.value.count < self.total else { return }
        guard !isLoading else{return}
        self.pageNumber += 1

        self.isLoading = true
        let query = MissionRequestModel.createRequestLuncher(page: pageNumber)
        self.membershipRepository.getMission(query: query) { result in
            switch result {
            case .success(let model):
                self.total = model.total ?? 0
                self.isLoading = false
                if self.pageNumber > 1 {
                    self.addNextPageData(model: model.mission)
                } else {
                    self.missions.value = model.mission ?? [MissionModel]()
                    
                }
                
            case .failure(let error):
                self.errorWithDismissViewController(message: error.localizedDescription)
                self.isLoading = false

            }

        }
        
    }
    
    private func addNextPageData(model: [MissionModel]?) {
        guard let model = model else{return}
        var indexPaths = [IndexPath]()
        for i in 0..<model.count {
            indexPaths.append(IndexPath(row: self.missions.value.count+i, section: 0))
        }
        self.missions.value.append(contentsOf:(model))
        self.reloadRows?(indexPaths)
    }
    

}
