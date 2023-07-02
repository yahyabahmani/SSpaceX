//
//  MissionModel.swift
//  SSpaceX
//
//  Created by yahya on 6/27/23.
//

import Foundation

struct MissionModelResponse: Codable {
    let docs: [Doc]?
    let totalDocs, limit, totalPages, page: Int?
    let pagingCounter: Int?
    let hasPrevPage, hasNextPage: Bool?
    let prevPage: Int?
    let nextPage: Int?
    
    struct Doc: Codable {
        let flightNumber,date_unix: Int?
        let name, details,id, dateUTC: String?
        let links: MediaLinks?
        let success: Bool?

        
        enum CodingKeys: String, CodingKey {
            case name, details, links,date_unix,id,success
            case flightNumber = "flight_number"
            case dateUTC = "date_utc"

        }
    }
    struct MediaLinks: Codable {
        let patch: Patch?
        let webcast: String?
        let wikipedia: String?
    }
    struct Patch: Codable {
        let small, large: String?
    }
}


struct MissionModelAll {
    
    var total:Int?
    var mission:[MissionModel]?
    
}
struct MissionModel {
    let id:String?
    let flightNumber:String?
    let totalPages: Int?
    let name, details, dateUTC: String?
    let smallPatch: String?
    let largePatch:String?
    let wikipedia:String?
    let success:Bool?
}
