//
//  SpaceShipVC.swift
//  SpaceGame
//
//  Created by Emre on 14.05.2022.
//

import UIKit

class SpaceShipVC: BaseVC {
    
    private let pointsTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Dağıtılacak Puan"
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    private let pointsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "12"
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let pointsHolderView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.5
        view.layer.borderColor = Colors.textColor.cgColor
        return view
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.textColor
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func setupSubviews() {
        [pointsTitleLabel, pointsHolderView, dividerView].forEach{view.addSubview($0)}
        [pointsLabel].forEach{pointsHolderView.addSubview($0)}
    }
    
    override func setupLayouts() {
        pointsHolderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(statusBarHeight() + 20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(60)
        }
        
        pointsTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(pointsHolderView)
            make.leading.equalToSuperview().offset(20)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(pointsHolderView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(2)
        }
        
    }

}
