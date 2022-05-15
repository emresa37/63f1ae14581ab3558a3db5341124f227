//
//  BaseVC.swift
//  SpaceGame
//
//  Created by Emre on 14.05.2022.
//

import UIKit
import SnapKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        setupSubviews()
        setupLayouts()
        setupActions()
    }
    
    func setupSubviews() {}
    func setupLayouts() {}
    func setupActions() {}
    

}
