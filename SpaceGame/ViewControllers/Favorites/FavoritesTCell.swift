//
//  FavoritesTCell.swift
//  SpaceGame
//
//  Created by Emre on 16.05.2022.
//

import UIKit

protocol FavoritesTCellProtocol: AnyObject {
    func favoriteButtonClicked(for item: FavoritesDBModel)
}

class FavoritesTCell: UITableViewCell {
    
    private let holderView: UIView = {
        let view = UIView()
        view.addBorder(width: 1.5, color: Colors.textColor)
        view.addCornerRadius()
        return view
    }()
    
    private let stationNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let eusLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favoriteFilled")?.mask(with: Colors.textColor), for: .normal)
        return button
    }()
    
    private var favoriteItem: FavoritesDBModel?
    weak var delegate: FavoritesTCellProtocol!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        setupSubviews()
        setupLayouts()
        setupActions()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        favoriteButton.setImage(UIImage(named: "favoriteFilled")?.mask(with: Colors.textColor), for: .normal)
        holderView.addBorder(width: 1.5, color: Colors.textColor)
    }
    
    private func setupSubviews() {
        contentView.addSubview(holderView)
        [stationNameLabel, eusLabel, favoriteButton].forEach{holderView.addSubview($0)}
    }
    
    private func setupLayouts() {
        holderView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(15)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
        
        stationNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(60)
        }
        
        eusLabel.snp.makeConstraints { make in
            make.top.equalTo(stationNameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupActions() {
        favoriteButton.addTarget(self, action: #selector(handleFavoriteButton), for: .touchUpInside)
    }
    
    @objc private func handleFavoriteButton() {
        guard let item = favoriteItem else { return }
        delegate.favoriteButtonClicked(for: item)
    }
    
    func config(item: FavoritesDBModel) {
        self.favoriteItem = item
        stationNameLabel.text = item.name
        eusLabel.text = "\(Favorites.shared.calculateTravelTime(for: item)) EUS"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
