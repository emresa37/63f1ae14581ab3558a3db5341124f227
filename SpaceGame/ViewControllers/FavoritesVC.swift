//
//  FavoritesVC.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import UIKit

class FavoritesVC: BaseVC {
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.text = "Favoriler"
        return lbl
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.textColor
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tv.separatorStyle = .none
        tv.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 50, right: 0)
        tv.backgroundColor = .clear
        tv.bounces = false
        return tv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupSubviews() {
        [titleLabel, dividerView, tableView].forEach{view.addSubview($0)}
    }
    
    override func setupLayouts() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(statusBarHeight() + 20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(2)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

}


extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Favorites.shared.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let fav = Favorites.shared.favorites[indexPath.row]
        cell.textLabel?.text = fav.name
        return cell
    }
    
    
}
