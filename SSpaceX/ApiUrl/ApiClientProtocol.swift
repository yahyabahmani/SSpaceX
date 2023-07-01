//
//  ApiClientProtocol.swift
//  snappTweet
//
//  Created by yahya on 4/23/22.
//

import Foundation
protocol ApiClientProtocol {
  func getMission(query: MissionRequestModel,completion: @escaping (Result<MissionModelAll, Error>) -> Void)  
}
