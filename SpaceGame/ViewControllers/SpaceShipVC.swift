//
//  SpaceShipVC.swift
//  SpaceGame
//
//  Created by Emre on 14.05.2022.
//

import UIKit

class SpaceShipVC: BaseVC {
    
    private let pointsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Dağıtılacak Puan"
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func setupSubviews() {
        [pointsLabel].forEach{view.addSubview($0)}
    }
    
    override func setupLayouts() {
        pointsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }

}
