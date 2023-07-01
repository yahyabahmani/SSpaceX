//
//  HTTPService.swift
//  snappTweet
//
//  Created by yahya on 4/23/22.
//

import Foundation

final class HTTPService {
  
    class func  request<T:Codable>(method: HTTPMethods, parameter: Dictionary<String, Any>? = nil,andUrl url:String, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let parameterTemp = parameter {
            let jsonData = try! JSONSerialization.data(withJSONObject: parameterTemp, options: [])
            request.httpBody = jsonData
            }
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(NSError(domain: "HTTPError", code: 0, userInfo: nil)))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "InvalidData", code: 0, userInfo: nil)))
                    return
                }

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                do {
                    let objectPromote  = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(objectPromote))
                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }

  
  

  class func parseError(statusCode: Int?) -> ClientError {
      guard let statusCode = statusCode else {
        return .unknown(message: ClientError.unknown(message: "").errorDescription)
      }
      switch statusCode {
      case 204:
          return .noContent
      case 401:
          return .unauthenticated
      case 500:
          return .internalServer
      default:
          let message = "error_on_connection_to_server_with_code \(statusCode)"
          return .unknown(message: message)
      }
  }
}
enum ClientError: Error {
    case unknown(message: String?)
    case unauthenticated
    case internalServer
    case parser
    case noContent
    case database
}
extension ClientError: LocalizedError {
   var errorDescription: String? {
        switch self {
        case .internalServer:
            return "Server Error"
        case .unauthenticated:
            return "unauthenticated error."
        case .parser:
            return "Parser error."
        case .unknown(let message):
          return "Unknown error \(message ?? "")"
        case .noContent:
            return "No Content"
        case .database:
          return "database Error"
        }
    }
}
