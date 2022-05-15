//
//  MainTabbarController.swift
//  SpaceGame
//
//  Created by Emre on 15.05.2022.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }
    
    private func configureViewControllers() {
        let homeVC = HomeVC()
        let homeTabbarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        homeVC.tabBarItem = homeTabbarItem
        
        let favoritesVC = FavoritesVC()
        let favoritesTabbarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        favoritesVC.tabBarItem = favoritesTabbarItem
        
        viewControllers = [
            homeVC,
            favoritesVC
        ]
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
