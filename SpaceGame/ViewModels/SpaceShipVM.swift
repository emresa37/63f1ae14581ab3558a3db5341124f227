//
//  SpaceShipVM.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation


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
        case updateAvailablePoints(value: String)
    }
    
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
    
    var binder: ((_ change: Change) -> Void)?
    
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
        
    }
    
    
}
