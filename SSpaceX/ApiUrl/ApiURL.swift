//
//  ApiURL.swift
//  snappTweet
//
//  Created by yahya on 4/23/22.
//

import Foundation
struct ApiURL {

    static let launches = "https://api.spacexdata.com/v5/launches/query"


}
public struct HTTPMethods: RawRepresentable, Equatable, Hashable {
    public let rawValue: String
    public var description: String { return rawValue }
    public var debugDescription: String {
        return "HTTP Method: \(rawValue)"
    }
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    public init(_ description: String) {
        rawValue = description.uppercased()
    }
    public static let get = HTTPMethods(rawValue: "GET")
    public static let post = HTTPMethods(rawValue: "POST")
    public static let put = HTTPMethods(rawValue: "PUT")
    public static let delete = HTTPMethods(rawValue: "DELETE")
    public static let head = HTTPMethods(rawValue: "HEAD")
    public static let patch = HTTPMethods(rawValue: "PATCH")
}
