//
//  TravelVM.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation

class TravelVM {
    
    enum Change {
        case updateTimer(value: Int)
    }
    
    var binder: ((_ change: Change) -> Void)?
    
    private var damageInterval: Double {
        get {
            return Double(Ship.shared.DS / 1000)
        }
    }
    private var counter: Int = 0 {
        didSet {
            binder?(.updateTimer(value: counter))
        }
    }
    
    func startTimer() {
        counter = Int(damageInterval)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTimerUpdate), userInfo: nil, repeats: true)
    }
    
    @objc private func handleTimerUpdate() {
        if counter > 0 {
            counter = counter - 1
        }else {
            counter = Int(damageInterval)
            if !Ship.shared.receiveDamage() {
                print("Needs to get back to earth")
            }
        }
    }
    
}
