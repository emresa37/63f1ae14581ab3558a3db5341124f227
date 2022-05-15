//
//  StationsResponseModel.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation

typealias StationsResponseModel = [Station]

struct Station: Codable {
    
    //MARK: Service variables
    let name: String?
    let coordinateX: Double?
    let coordinateY: Double?
    var need: Int?
    let capacity: Int?
    var stock: Int?
    
    var isCurrentStation: Bool {
        get {
            return name == Ship.shared.currentStation?.name
        }
    }
    
    var travelTime: Int {
        get {
            let currentStation = Ship.shared.currentStation
            let xWay = abs((currentStation?.coordinateX ?? 0) - (coordinateX ?? 0))
            let yWay = abs((currentStation?.coordinateY ?? 0) - (coordinateY ?? 0))
            return Int(xWay + yWay)
        }
    }
    
    var canTravel: Bool {
        get {
            return (Ship.shared.EUS > travelTime) && (Ship.shared.UGS > 0)
        }
    }
    
}
