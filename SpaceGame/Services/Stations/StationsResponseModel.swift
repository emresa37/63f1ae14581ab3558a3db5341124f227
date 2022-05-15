//
//  StationsResponseModel.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation

typealias StationsResponseModel = [Station]

struct Station: Codable {
    let name: String?
    let coordinateX: Double?
    let coordinateY: Double?
    let need: Int?
    let capacity: Int?
    let stock: Int?
}
