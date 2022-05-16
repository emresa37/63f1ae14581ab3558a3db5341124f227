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
        case updateStations
        case needsToGetBackToEarth
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
    var stations: [Station] = [] {
        didSet {
            binder?(.updateStations)
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
                getBackToEarth()
            }
        }
    }
    
    func fetchStations() {
        Services.stations() { result in
            switch result {
            case .success(let stations):
                DispatchQueue.main.async {
                    guard let first = stations.first else { return }
                    Ship.shared.setCurrentStation(station: first)
                    self.stations = stations
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func travel(to station: Station) {
        if station.canTravel {
            let travelledStation = Ship.shared.travel(to: station)
            let travelledIndex = self.stations.firstIndex(where: {
                return $0.name == travelledStation.name
            })
            guard let index = travelledIndex else { return }
            stations[index] = travelledStation
            checkIfCanTravel()
        }
    }
    
    private func checkIfCanTravel() {
        if !Ship.shared.canTravel(stations: stations) {
            getBackToEarth()
        }
    }
    
    private func getBackToEarth() {
        guard let first = stations.first else { return }
        Ship.shared.setCurrentStation(station: first)
        Ship.shared.refreshShip()
        binder?(.needsToGetBackToEarth)
    }
    
    func handleFavorite(for station: Station) {
        if station.isFavorited {
            Favorites.shared.removeFavorite(name: station.name ?? "")
        }else {
            Favorites.shared.addFavorite(station: station)
        }
        
        binder?(.updateStations)
    }
    
}
