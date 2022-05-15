//
//  UIView+Extension.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import Foundation
import UIKit


let screenSize: CGSize = UIScreen.main.bounds.size

extension UIView {
    func addTarget(_ target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    func addCornerRadius(radius: CGFloat = 6) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }

    func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
