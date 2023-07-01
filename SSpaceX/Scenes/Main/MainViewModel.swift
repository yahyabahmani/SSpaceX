//
//  MainViewModel.swift
//  SSpaceX
//
//  Created by yahya on 6/27/23.
//

import Foundation
import Combine
final class MainViewModel: BaseViewModel {
    private let membershipRepository = MembershipRepository()
    private var total: Int = 1
    private var pageNumber: Int = 0
    var isLoading = false
    let indexMission = PassthroughSubject<[IndexPath], Never>()
    let missions = CurrentValueSubject<[MissionModel], Never>([MissionModel]())
    var isLastPage = false
    
    func showDetails(_ model: MissionModel) {
        (self.coordinator as? MainCoordinator)?.showDetails(model)
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
                self.addNextPageData(model: model.mission, total: model.total)
                
            case .failure(let error):
                self.errorWithDismissViewController(message: error.localizedDescription)
                self.isLoading = false
            }
            
        }
    }
        
    
    
    private func addNextPageData(model: [MissionModel]?,total:Int?) {
        guard let model = model else{return}
        guard let total = total else{return}
        
        var indexPaths = [IndexPath]()
        for i in 0..<model.count {
            indexPaths.append(IndexPath(row: self.missions.value.count+i, section: 0))
        }
        self.missions.value.append(contentsOf:(model))
        indexMission.send(indexPaths)

        guard total > self.missions.value.count else{
            self.isLastPage = true
            return
        }

    }
    

}
