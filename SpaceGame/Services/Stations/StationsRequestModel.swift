//
//  StationsRequestModel.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation

class StationsRequestModel: RequestModel {
    
    // MARK: - Properties
    
    override var path: String {
        return Constants.ServiceConstant.stations
    }
    
    override var parameters: [String : Any?] {
        return [:]
    }
    
    override var headers: [String : String] {
        return [:]
    }
}
