//
//  FavoritesDBManager.swift
//  SpaceGame
//
//  Created by Emre on 16.05.2022.
//

import Foundation
import SQLite

class FavoritesDBManager {
    
    private let db: Connection?
    
    private let tblFavoritesDataDB = Table("favorites")
    
    private var data = [FavoritesDBModel]()
    
    init() {
        db = DBManager.shared.db
    }
    
    func fetchFromDB(closure: ([FavoritesDBModel])->Void) {
        data.removeAll()
        fetchFavoriteData()
        closure(data)
    }
    
    func addFavorite(input: FavoritesDBModel) {
        do {
            let insert = tblFavoritesDataDB.insert(
                FavoritesDBExpressions.name <- input.name,
                FavoritesDBExpressions.coordinateY <- input.coordinateY,
                FavoritesDBExpressions.coordinateX <- input.coordinateX
            )
            let _ = try db!.run(insert)
        } catch {
            return
        }
    }
    
    func removeFavorite(name: String) {
        do {
            let filteredFavorite = tblFavoritesDataDB.filter(FavoritesDBExpressions.name == name)
            let delete = filteredFavorite.delete()
            if try db!.run(delete) > 0 {
                print("Deleted successfully")
            }
        } catch {
            return
        }
    }
    
}

//MARK: Fetching data
extension FavoritesDBManager {
    private func fetchFavoriteData() {
        do {
            guard let items = try db?.prepare(self.tblFavoritesDataDB) else { return }
            
            for fav in items {
                let item = FavoritesDBModel(name: fav[FavoritesDBExpressions.name],
                                        coordinateX: fav[FavoritesDBExpressions.coordinateX],
                                        coordinateY: fav[FavoritesDBExpressions.coordinateY])
                data.append(item)
            }
        } catch {
            print("Cannot get list of product")
        }
    }
}

//MARK: Expressions
extension FavoritesDBManager {
    private struct FavoritesDBExpressions {
        static let name = Expression<String>("name")
        static let coordinateX = Expression<Int>("coordinateX")
        static let coordinateY = Expression<Int>("coordinateY")
    }
}

struct FavoritesDBModel {
    var name: String
    var coordinateX: Int
    var coordinateY: Int
}
