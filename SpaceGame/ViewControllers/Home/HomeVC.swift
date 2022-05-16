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
        lbl.addBorder(width: 1.5, color: Colors.textColor)
        return lbl
    }()
    
    private let timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.addBorder(width: 1.5, color: Colors.textColor)
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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(StationCCell.self, forCellWithReuseIdentifier: "cellID")
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let currentStationLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.numberOfLines = 2
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var travelVM: TravelVM = {
        let vm = TravelVM()
        return vm
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshShipData()
        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        registerNotifications()
        travelVM.startTimer()
        travelVM.fetchStations()
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshShipData), name: Notification.Name(Notifications.shipUpdateNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, forKeyPath: Notifications.shipUpdateNotification)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        healthLabel.addBorder(width: 1.5, color: Colors.textColor)
        timerLabel.addBorder(width: 1.5, color: Colors.textColor)
    }
    
    override func setupSubviews() {
        [infoHolderStack, dividerView, healthHolderStack, shipNameLabel, collectionView, currentStationLabel].forEach{view.addSubview($0)}
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
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(shipNameLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(view.snp.width).offset(-120)
        }
        
        currentStationLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
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
            case .updateStations:
                self.collectionView.reloadData()
                self.refreshShipData()
            case .needsToGetBackToEarth:
                self.collectionView.reloadData()
                let index = IndexPath(row: 0, section: 0)
                self.collectionView.scrollToItem(at: index, at: .left, animated: true)
            }
        }
    }
    
    private func animateHealthLabel() {
        UIView.animate(withDuration: 0.3, delay: 1, options: .curveEaseInOut) {
            self.healthLabel.addBorder(width: 1.5, color: .red)
        } completion: { (true) in
            self.healthLabel.addBorder(width: 1.5, color: Colors.textColor)
        }
    }
    
    @objc private func refreshShipData() {
        UGSLabel.text = "UGS : \(Ship.shared.UGS)"
        EUSLabel.text = "EUS : \(Ship.shared.EUS)"
        DSLabel.text = "DS : \(Ship.shared.DS)"
        shipNameLabel.text = Ship.shared.name
        healthLabel.text = "\(Ship.shared.health)"
        currentStationLabel.text = Ship.shared.currentStation?.name
    }

}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return travelVM.stations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! StationCCell
        let station = travelVM.stations[indexPath.row]
        cell.configure(station: station)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.width - 120, height: screenSize.width - 120)
    }
    
    
}


extension HomeVC: StationCCellProtocol {
    func favoriteButtonClicked(for station: Station?) {
        guard let station = station else { return }
        travelVM.handleFavorite(for: station)
    }
    
    func travelButtonClicked(for station: Station?) {
        guard let station = station else { return }
        travelVM.travel(to: station)
    }
    
}
