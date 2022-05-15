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
    
    fileprivate(set) var name: String
    private var durability: Int
    private var speed: Int
    private var capacity: Int
    
    fileprivate(set) var UGS: Int = 0
    fileprivate(set) var EUS: Int = 0
    fileprivate(set) var DS: Int = 0
    fileprivate(set) var health: Int = 100

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
        
        self.configureInitialValues()
    }
    
    private func configureInitialValues() {
        UGS = capacity * 10000
        EUS = speed * 20
        DS = durability * 10000
    }
    
}
