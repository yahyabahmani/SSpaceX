//
//  ApiClientProtocol.swift
//  snappTweet
//
//  Created by yahya on 4/23/22.
//

import Foundation
protocol ApiClientProtocol {
  func getMission(query: MissionRequestModel,completion: @escaping (Result<MissionModelAll, Error>) -> Void)
//    func  getMissionResult(query: MissionRequestModel, success succeeds:@escaping ([MissionModel])->(), failure failed:@escaping (Error)->())
//  func removeRule(query: String, success succeeds:@escaping (TweetRemoveResult)->(), failure failed:@escaping (Error)->())
//  func getStream( success succeeds:@escaping (TweetData)->(), failure failed:@escaping (Error)->())
  
}
