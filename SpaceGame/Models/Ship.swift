//
//  Ship.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation

class Ship {
    static let shared = Ship()
    private static var config: ShipDbModel?
    
    var name: String
    var durability: Int
    var speed: Int
    var capacity: Int

    class func setup(_ config: ShipDbModel){
        Ship.config = config
    }

    private init() {
        guard let config = Ship.config else {
            fatalError("Error - you must call setup before accessing MySingleton.shared")
        }
        
        self.name = config.name
        self.durability = config.durability
        self.speed = config.speed
        self.capacity = config.capacity
    }
    
    
    
    
}
