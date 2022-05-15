//
//  RequestModel.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import UIKit

enum RequestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class RequestModel: NSObject {
    
    // MARK: - Properties
    var path: String {
        return ""
    }
    var parameters: [String: Any?] {
        return [:]
    }
    var headers: [String: String] {
        return [:]
    }
    var method: RequestHTTPMethod {
        return body.isEmpty ? RequestHTTPMethod.get : RequestHTTPMethod.post
    }
    var body: [String: Any?] {
        return [:]
    }
    
    // (request, response)
    var isLoggingEnabled: (Bool, Bool) {
        return (false, false)
    }
}

// MARK: - Public Functions
extension RequestModel {
    
    func urlRequest() -> URLRequest {
        var endpoint: String = ServiceManager.shared.baseURL.appending(path)
        var firstIndex = true
        
        for parameter in parameters {
            if let value = parameter.value as? String {
                if firstIndex {
                    endpoint.append("?\(parameter.key)=\(value)")
                    firstIndex = false
                }else {
                    endpoint.append("&\(parameter.key)=\(value)")
                }
            }
        }
        
        var request: URLRequest = URLRequest(url: URL(string: endpoint)!)
        
        request.httpMethod = method.rawValue
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if method == RequestHTTPMethod.post {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let error {
                LogManager.e("Request body parse error: \(error.localizedDescription)")
            }
        }
        
        return request
    }
}
