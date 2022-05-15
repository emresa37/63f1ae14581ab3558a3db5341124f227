//
//  Services.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation

class Services {
    
    class func stations(completion: @escaping(Swift.Result<StationsResponseModel, ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: StationsRequestModel()) { (result) in
            completion(result)
        }
    }
    
}
