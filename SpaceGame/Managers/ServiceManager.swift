//
//  ServiceManager.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation

class ServiceManager {
    
    // MARK: - Properties
    static let shared: ServiceManager = ServiceManager()
    
    var baseURL: String = Constants.baseURL
}

// MARK: - Public Functions
extension ServiceManager {
    
    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) {
        if request.isLoggingEnabled.0 {
            LogManager.req(request)
        }
        let urlReq = request.urlRequest()
        URLSession.shared.dataTask(with: urlReq) { data, response, error in
            guard let data = data, let parsedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
                LogManager.err(error)

                completion(Result.failure(error))
                return
            }

            var responseModel: ResponseModel<T> = .init()
            responseModel.isSuccess = true
            responseModel.data = parsedResponse
            responseModel.rawData = data
            responseModel.request = request

            if request.isLoggingEnabled.1 {
                LogManager.res(responseModel)
            }

            if responseModel.isSuccess, let data = responseModel.data {
                completion(Result.success(data))
            } else {
                completion(Result.failure(ErrorModel.generalError()))
            }
        }.resume()
    }
}
