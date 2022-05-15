//
//  StationCCell.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import UIKit

class StationCCell: UICollectionViewCell {
    
    private let holderView: UIView = {
        let view = UIView()
        view.addCornerRadius()
        view.addBorder(width: 1.5, color: Colors.textColor)
        return view
    }()
    
    private let capacityLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    private let eusLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    private let stationNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.8
        return lbl
    }()
    
    private let travelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Travel", for: .normal)
        button.backgroundColor = Colors.textColor.withAlphaComponent(0.3)
        button.addBorder(width: 1, color: Colors.textColor)
        button.addCornerRadius()
        return button
    }()
    
    private var station: Station?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayouts()
        setupActions()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        holderView.addBorder(width: 1.5, color: Colors.textColor)
    }
    
    private func setupSubviews() {
        [holderView].forEach{contentView.addSubview($0)}
        [capacityLabel, eusLabel, stationNameLabel, travelButton].forEach{holderView.addSubview($0)}
    }
    
    private func setupLayouts() {
        holderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        capacityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
        }
        
        eusLabel.snp.makeConstraints { make in
            make.top.equalTo(capacityLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        
        stationNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        travelButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
    }
    
    private func setupActions() {
        travelButton.addTarget(self, action: #selector(handleTravelButton), for: .touchUpInside)
    }
    
    @objc private func handleTravelButton() {
        print("handle Travel button")
    }
    
    func configure(station: Station) {
        self.station = station
        stationNameLabel.text = station.name
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
