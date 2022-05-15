//
//  ShipLocalModel.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation
import SQLite

class ShipDbManager {
    
    private let db: Connection?
    
    private let tblShipDataDB = Table("spaceship")
    
    private var data = [ShipDbModel]()
    
    init() {
        db = DBManager.shared.db
    }
    
    func fetchFromDB(closure: (ShipDbModel?)->Void) {
        data.removeAll()
        fetchShipData()
        if data.count > 1 {
            clearDB {
                closure(nil)
            }
        }else {
            closure(data.first)
        }
    }
    
    private func clearDB(closure: ()->Void) {
        do {
            let delete = tblShipDataDB.delete()
            try db!.run(delete)
            closure()
        } catch {
            print("delete failed: \(error)")
        }
    }
    
    func saveShip(input: ShipDbModel) {
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
    
    func updateShip(input: ShipDbModel) {
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
extension ShipDbManager {
    private func fetchShipData() {
        do {
            guard let items = try db?.prepare(self.tblShipDataDB) else { return }
            
            for ship in items {
                let item = ShipDbModel(name: ship[ShipDBExpressions.name],
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
extension ShipDbManager {
    private struct ShipDBExpressions {
        static let name = Expression<String>("name")
        static let durability = Expression<Int>("durability")
        static let speed = Expression<Int>("speed")
        static let capacity = Expression<Int>("capacity")
    }
}

struct ShipDbModel {
    var name: String
    var durability: Int
    var speed: Int
    var capacity: Int
}
