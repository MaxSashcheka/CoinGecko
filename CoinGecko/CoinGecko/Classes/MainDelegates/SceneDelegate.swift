//
//  SceneDelegate.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        window = UIWindow(windowScene: windowScene)
        
        appCoordinator = AppAssembly.appCoordinator()

        appCoordinator.start(at: window)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window = window
        }
    }
}
