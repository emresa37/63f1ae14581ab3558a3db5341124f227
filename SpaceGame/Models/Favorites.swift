//
//  Favorites.swift
//  SpaceGame
//
//  Created by Emre on 16.05.2022.
//

import Foundation

class Favorites {
    static let shared = Favorites()
    private let localDB = FavoritesDBManager()
    fileprivate(set) var favorites = [FavoritesDBModel]()
    
    init() {
        localDB.fetchFromDB { [weak self] favorites in
            self?.favorites = favorites
        }
    }
    
    func isFavorited(station: Station) -> Bool {
        return favorites.contains(where: {
            $0.name == station.name
        })
    }
    
    func addFavorite(station: Station) {
        let model = FavoritesDBModel(name: station.name ?? "",
                                     coordinateX: Int(station.coordinateX ?? 0),
                                     coordinateY: Int(station.coordinateY ?? 0))
        favorites.append(model)
        localDB.addFavorite(input: model)
    }
    
    func removeFavorite(name: String) {
        favorites.removeAll(where: {
            $0.name == name
        })
        
        localDB.removeFavorite(name: name)
    }
    
    func calculateTravelTime(for item: FavoritesDBModel) -> Int {
        let xWay = abs(item.coordinateX)
        let yWay = abs(item.coordinateY)
        return Int(xWay + yWay)
    }
    
}
