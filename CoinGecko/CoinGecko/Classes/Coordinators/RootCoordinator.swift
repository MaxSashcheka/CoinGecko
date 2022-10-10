//
//  RootCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit
import Utils

final class RootCoordinator: TabCoordinator {

    override func registerContent() {
        
    }

    func start(at window: UIWindow?) {
        assert(window.nonNil, "Root Window is nil")
        window?.rootViewController = baseViewController
        window?.makeKeyAndVisible()

        initializeTabsCoordinatorsAndShow()
        setupAppearance()
    }
    
    func setupAppearance() {
        let navigationAppearance = UINavigationBarAppearance()
        let backButtonImage = Assets.Images.back.image
        navigationAppearance.setBackIndicatorImage(backButtonImage,
                                                   transitionMaskImage: backButtonImage)
        
        let navigationBar: UINavigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = .black
        
        navigationBar.standardAppearance = navigationAppearance
        navigationBar.compactAppearance = navigationAppearance
        navigationBar.scrollEdgeAppearance = navigationAppearance
    }
}

private extension RootCoordinator {
    func initializeTabsCoordinatorsAndShow() {
        let homeCoordinator = RootAssembly.makeHomeCoordinator(parent: self)
        let marketsCoordinator = RootAssembly.makeMarketsCoordinator(parent: self)
        let profileCoordinator = RootAssembly.makeProfileCoordinator(parent: self)
        
        let coordinators = [
            homeCoordinator,
            marketsCoordinator,
            profileCoordinator
        ]

        setTabsCoordinators(coordinators)
        
        // TODO: - Fix this
        DispatchQueue.main.async { [weak self] in
            self?.selectViewController(withCoordinatorType: HomeCoordinator.self)
            self?.selectViewController(withCoordinatorType: MarketsCoordinator.self)
        }
       
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
    }
}
