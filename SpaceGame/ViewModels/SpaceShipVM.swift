//
//  SpaceShipVM.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation
import QuartzCore

class SpaceShipVM {
    
    enum SliderType: Int {
        case durability = 0
        case speed = 1
        case capacity = 2
    }
    
    enum Change {
        case setDurability(value: Float)
        case setSpeed(value: Float)
        case setCapacity(value: Float)
        case setShipName(value: String)
        case updateAvailablePoints(value: String)
        case shipSaved(ship: ShipDbModel)
    }
    
    private var hasSavedShip = false
    private let minPoint: Float = 1
    private let totalPoints: Float = 15
    private var durability: Float = 1 {
        didSet {
            binder?(.setDurability(value: durability))
            updateAvailablePoints()
        }
    }
    private var speed: Float = 1 {
        didSet {
            binder?(.setSpeed(value: speed))
            updateAvailablePoints()
        }
    }
    private var capacity: Float = 1 {
        didSet {
            binder?(.setCapacity(value: capacity))
            updateAvailablePoints()
        }
    }
    
    private let localDB = ShipDbManager()
    var binder: ((_ change: Change) -> Void)? {
        didSet {
            fetchShipData()
        }
    }
    
    func handleValueChange(for type: SliderType, value: Float) {
        switch type {
        case .durability:
            if value < minPoint {
                durability = minPoint
                return
            }
            let availablePoints = Float(totalPoints - (speed + capacity))
            let calculated = value < availablePoints ? value : availablePoints
            durability = calculated
        case .speed:
            if value < minPoint {
                speed = minPoint
                return
            }
            let availablePoints = Float(totalPoints - (durability + capacity))
            let calculated = value < availablePoints ? value : availablePoints
            speed = calculated
        case .capacity:
            if value < minPoint {
                capacity = minPoint
                return
            }
            let availablePoints = Float(totalPoints - (durability + speed))
            let calculated = value < availablePoints ? value : availablePoints
            capacity = calculated
        }
    }
    
    private func updateAvailablePoints() {
        let availablePoints = Int(totalPoints - (speed + capacity + durability))
        binder?(.updateAvailablePoints(value: String(availablePoints)))
    }
    
    func saveShip(with name: String) {
        if binder == nil {
            return
        }
        let ship = ShipDbModel(name: name,
                        durability: Int(durability),
                        speed: Int(speed),
                        capacity: Int(capacity))
        
        if hasSavedShip {
            localDB.updateShip(input: ship)
        }else {
            localDB.saveShip(input: ship)
            hasSavedShip = true
        }
        
        binder?(.shipSaved(ship: ship))
    }
    
    func fetchShipData() {
        localDB.fetchFromDB { [weak self] ship in
            guard let self = self else{return}
            guard let ship = ship else {
                self.hasSavedShip = false
                return
            }
            self.hasSavedShip = true
            self.durability = Float(ship.durability)
            self.speed = Float(ship.speed)
            self.capacity = Float(ship.capacity)
            self.binder?(.setShipName(value: ship.name))
        }
    }
    
}
