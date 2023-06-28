//
//  MissionRequestModel.swift
//  SSpaceX
//
//  Created by Jabama on 6/27/23.
//

import Foundation

struct MissionRequestModel: Codable {
    let query: Query?
    let options: Options?
    // MARK: - Options
    struct Options: Codable {
        let limit, page: Int?
        let sort: SortQuery?
    }

    // MARK: - Sort
    struct SortQuery: Codable {
        let flight_number: String?

       
    }

    // MARK: - Query
    struct Query: Codable {
        let upcoming: Bool?
    }
    
    
 static func createRequestLuncher(page:Int)->MissionRequestModel {
    
         return MissionRequestModel(query: Query(upcoming: false), options: Options(limit: 20, page: page, sort: SortQuery(flight_number:"desc")))
    }
    
}


