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
    
//class func request<T:Codable>(method: HTTPMethod, parameter: Dictionary<String, Any>? = nil,andUrl url:String,succeeded: @escaping ((T)->()),failure failed: @escaping ((Error)->())) {
//      let headers: HTTPHeaders = [.authorization(bearerToken: ApiURL.token)]
//  AF.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: headers).validate().response { response in
//            switch  response.result {
//
//            case .success:
//            guard let value = response.data else {return}
//            do {
//                let objectPromote  = try JSONDecoder().decode(T.self, from: value)
//
//                succeeded(objectPromote)
//            } catch {
//                print(error)
//              failed(ClientError.parser )
//
//            }
//            case .failure(_):
//              failed(parseError(statusCode: response.response?.statusCode))
//            }
//        }
//}
//  class func streamRequest<T:Codable>(method: HTTPMethod, parameter: Dictionary<String, Any>? = nil,andUrl url:String,succeeded: @escaping ((T)->()),failure failed: @escaping ((Error)->())) {
//        let headers: HTTPHeaders = [.authorization(bearerToken: ApiURL.token)]
//    AF.streamRequest(url, method: method, headers: headers, automaticallyCancelOnStreamError: false).validate().responseStreamDecodable(of: T.self) { response in
//      switch response.event {
//         case let .stream(result):
//             switch result {
//             case let .success(value):
//               succeeded(value)
//             case let .failure(error):
//                 print(error)
//             }
//         case let .complete(completion):
//             print(completion)
//         }
//
//    }
//
//
//  }
  
  
  

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
