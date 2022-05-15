//
//  Constans.swift
//  SpaceGame
//
//  Created by Emre on 14.05.2022.
//

import Foundation
import UIKit

struct Constants {
    
}

struct Notifications {
    static let shipUpdateNotification = "shipUpdateNotification"
}


struct Colors {
    public static var backgroundColor: UIColor {
        get {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return .white
            }
        }
    }
    public static var textColor: UIColor {
        get {
            if #available(iOS 13.0, *) {
                return UIColor(named: "TextColor") ?? .black
            } else {
                return .black
            }
        }
    }
}
