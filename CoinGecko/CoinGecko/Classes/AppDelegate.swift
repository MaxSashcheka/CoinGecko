//
//  AppDelegate.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 12.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var rootCoordinator: RootCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        rootCoordinator = RootAssembly.makeRootCoordinator()

        window = UIWindow(frame: UIScreen.main.bounds)
        rootCoordinator.start(at: window)
        
        return true
    }
}

