//
//  DBManager.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation
import SQLite

class DBManager {
    var db: Connection?
    
    static let shared: DBManager = {
        let instance = DBManager()
        return instance
    }()
    
    fileprivate init() {
        do {
            let fileURL = try! FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("localData.sqlite")
            openDB(fileURL: fileURL)
            
            self.db = try Connection(fileURL.absoluteString)
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    
    private func openDB(fileURL: URL) {
        var db: OpaquePointer?
        guard sqlite3_open(fileURL.path, &db) == SQLITE_OK else {
            print("error opening database")
            sqlite3_close(db)
            db = nil
            return
        }
        
        if sqlite3_exec(db, "create table if not exists " +
                        "spaceship " +
                        "(name text, " +
                        "durability int, " +
                        "speed int, " +
                        "capacity int)"
                        , nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    
}
