//
//  ErrorModel.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation

class ErrorModel: Error {
    
    // MARK: - Properties
    var messageKey: String
    var message: String {
        return messageKey
    }
    
    init(_ messageKey: String) {
        self.messageKey = messageKey
    }
}

// MARK: - Public Functions
extension ErrorModel {
    
    class func generalError() -> ErrorModel {
        return ErrorModel(ErrorKey.general.rawValue)
    }
}
