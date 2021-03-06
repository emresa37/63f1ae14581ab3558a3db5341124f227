//
//  AppDelegate.swift
//  SpaceGame
//
//  Created by Emre on 14.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let dir = NSHomeDirectory()
        NSLog(dir)
        
        configureOpeningPage()
        
        return true
    }
    
    private func configureOpeningPage() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = SpaceShipVC()
        if #available(iOS 13.0, *) {
            window!.backgroundColor = .systemBackground
        } else {
            window!.backgroundColor = .white
        }
        window!.makeKeyAndVisible()
    }


}

