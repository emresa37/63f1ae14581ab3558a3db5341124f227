//
//  UIView+Extension.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation
import UIKit

extension UIView {
    func addTarget(_ target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
}
