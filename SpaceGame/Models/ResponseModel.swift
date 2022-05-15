//
//  ResponseModel.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation

struct ResponseModel<T: Codable>: Codable {
    
    // MARK: - Properties
    var isSuccess: Bool
    var message: String
    var error: ErrorModel {
        return ErrorModel(message)
    }
    var rawData: Data?
    var data: T?
    var json: String? {
        guard let rawData = rawData else { return nil }
        return String(data: rawData, encoding: String.Encoding.utf8)
    }
    var request: RequestModel?

    init() {
        self.isSuccess = false
        self.message = ""
    }
    
    init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        isSuccess = (try? keyedContainer.decode(Bool.self, forKey: CodingKeys.isSuccess)) ?? false
        message = (try? keyedContainer.decode(String.self, forKey: CodingKeys.message)) ?? ""
        data = try? keyedContainer.decode(T.self, forKey: CodingKeys.data)
    }
}

// MARK: - Private Functions
extension ResponseModel {

    private enum CodingKeys: String, CodingKey {
        case isSuccess
        case message
        case data
    }
}
