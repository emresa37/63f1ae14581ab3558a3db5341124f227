//
//  HomeVC.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import UIKit

class HomeVC: BaseVC {
    
    private let infoHolderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 2
        return stack
    }()
    
    private let UGSLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private let EUSLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private let DSLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.textColor
        return view
    }()
    
    private let healthHolderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    private let healthLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.layer.borderWidth = 1.5
        lbl.layer.borderColor = Colors.textColor.cgColor
        return lbl
    }()
    
    private let timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.layer.borderWidth = 1.5
        lbl.layer.borderColor = Colors.textColor.cgColor
        return lbl
    }()
    
    private let shipNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 2
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private lazy var travelVM: TravelVM = {
        let vm = TravelVM()
        return vm
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshShipData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        registerNotifications()
        travelVM.startTimer()
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshShipData), name: Notification.Name(Notifications.shipUpdateNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, forKeyPath: Notifications.shipUpdateNotification)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        healthLabel.layer.borderColor = Colors.textColor.cgColor
        timerLabel.layer.borderColor = Colors.textColor.cgColor
    }
    
    override func setupSubviews() {
        [infoHolderStack, dividerView, healthHolderStack, shipNameLabel].forEach{view.addSubview($0)}
        [UGSLabel, EUSLabel, DSLabel].forEach{infoHolderStack.addArrangedSubview($0)}
        [healthLabel, timerLabel].forEach{healthHolderStack.addArrangedSubview($0)}
    }
    
    override func setupLayouts() {
        infoHolderStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(statusBarHeight() + 20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(infoHolderStack.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(2)
        }
        
        healthHolderStack.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
        
        shipNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(healthHolderStack)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(healthHolderStack.snp.leading).offset(-10)
        }
        
    }
    
    private func bind() {
        travelVM.binder  = { [weak self] (change) in
            guard let self = self else { return }
            switch change {
            case .updateTimer(let value):
                self.timerLabel.text = "\(value)"
                if value == 0 {
                    self.animateHealthLabel()
                }
            }
        }
    }
    
    private func animateHealthLabel() {
        UIView.animate(withDuration: 0.3, delay: 1, options: .curveEaseInOut) {
            self.healthLabel.layer.borderColor = UIColor.red.cgColor
        } completion: { (true) in
            self.healthLabel.layer.borderColor = Colors.textColor.cgColor
        }
    }
    
    @objc private func refreshShipData() {
        UGSLabel.text = "UGS : \(Ship.shared.UGS)"
        EUSLabel.text = "EUS : \(Ship.shared.EUS)"
        DSLabel.text = "DS : \(Ship.shared.DS)"
        shipNameLabel.text = Ship.shared.name
        healthLabel.text = "\(Ship.shared.health)"
    }

}
