//
//  ShipLocalModel.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation
import SQLite

class ShipLocalModel {
    
    private let db: Connection?
    
    private let tblShipDataDB = Table("spaceship")
    
    private var data = [Ship]()
    
    init() {
        db = DBManager.shared.db
    }
    
    func fetchFromDB(closure: (Ship?)->Void) {
        data.removeAll()
        fetchShipData()
        closure(data.first)
    }
    
    func saveShip(input: Ship) {
        do {
            let insert = tblShipDataDB.insert(
                ShipDBExpressions.name <- input.name,
                ShipDBExpressions.durability <- input.durability,
                ShipDBExpressions.speed <- input.speed,
                ShipDBExpressions.capacity <- input.capacity
            )
            let _ = try db!.run(insert)
        } catch {
            return
        }
    }
    
    func updateShip(input: Ship) {
        do {
            let update = tblShipDataDB.update(
                ShipDBExpressions.name <- input.name,
                ShipDBExpressions.durability <- input.durability,
                ShipDBExpressions.speed <- input.speed,
                ShipDBExpressions.capacity <- input.capacity
            )
            let _ = try db!.run(update)
        } catch {
            return
        }
    }
    
}

//MARK: Fetching data
extension ShipLocalModel {
    private func fetchShipData() {
        do {
            guard let items = try db?.prepare(self.tblShipDataDB) else { return }
            
            for ship in items {
                let item = Ship(name: ship[ShipDBExpressions.name],
                                durability: ship[ShipDBExpressions.durability],
                                speed: ship[ShipDBExpressions.speed],
                                capacity: ship[ShipDBExpressions.capacity])
                data.append(item)
            }
        } catch {
            print("Cannot get list of product")
        }
    }
}

//MARK: Expressions
extension ShipLocalModel {
    private struct ShipDBExpressions {
        static let name = Expression<String>("name")
        static let durability = Expression<Int>("durability")
        static let speed = Expression<Int>("speed")
        static let capacity = Expression<Int>("capacity")
    }
}

struct Ship {
    var name: String
    var durability: Int
    var speed: Int
    var capacity: Int
}
