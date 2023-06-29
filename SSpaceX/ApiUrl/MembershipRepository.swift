//
//  MembershipRepository.swift
//  snappTweet
//
//  Created by yahya on 4/23/22.
//

import Foundation
struct MembershipRepository: ApiClientProtocol {
    
    
    func getMission(query: MissionRequestModel, completion: @escaping (Result<MissionModelAll, Error>) -> Void) {
        let url = ApiURL.launches
        let parameter = query.dictionary
        
        HTTPService.request(method: .post,parameter:parameter, andUrl: url){ (result: Result<MissionModelResponse, Error>) in
            switch result {
            case .success(let success):
                if let mission =  mapperMissionModelResponseToMissionModel(response: success) {
                    completion(.success(mission))
                }else{
                    completion(.failure(ClientError.noContent))
                    
                }
                
            case .failure(let failure):
                completion(.failure(failure))
                
            }
            
        }
    }
        func mapperMissionModelResponseToMissionModel(response:MissionModelResponse)->MissionModelAll?{
            guard let docs = response.docs else{return nil}
            
            let missionModel =   docs.map { item in
                let dateFormatter = DateFormatter.localizedDateFormatter()
                let date = Date(timeIntervalSince1970: TimeInterval(item.date_unix ?? 0))
                let  dateString =  Constants.dateString + dateFormatter.string(from: date)
                let flightNumber = Constants.flightNumber + "\(item.flightNumber ?? 0)"
                
                return MissionModel(flightNumber: flightNumber, totalPages:response.totalPages, name: item.name, details: item.details, dateUTC: dateString, smallPatch: item.links?.patch?.small, largePatch: item.links?.patch?.large,wikipedia:item.links?.wikipedia)
            }
            return MissionModelAll(total: response.totalDocs, mission: missionModel)
        }
        
        
        
        
    }
    
    
