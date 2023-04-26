//
//  AppCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import SafeSFSymbols
import UIKit
import Utils

final class AppCoordinator: TabCoordinator {
    override func registerContent() {
        register(SessionsAssembly.coinsCacheDataManager(resolver: self))
        register(SessionsAssembly.postsCacheDataManager(resolver: self))
        register(SessionsAssembly.usersCacheDataManager(resolver: self))
        register(SessionsAssembly.walletsCacheDataManager(resolver: self))
        register(SessionsAssembly.appPropertiesDataManager(resolver: self))
        register(AppAssembly.externalLinkBuilder())
    }
    
    var appPropertiesDataManager: AppPropertiesDataManager {
        resolve(AppPropertiesDataManager.self)
    }
    
    var usersCacheDataManager: UsersCacheDataManager {
        resolve(UsersCacheDataManager.self)
    }

    func start(at window: UIWindow?) {
        assert(window.nonNil, "Root Window is nil")
        window?.rootViewController = baseViewController
        window?.makeKeyAndVisible()
        
        authenticateStoredUserIfPossible()

        initializeTabsCoordinatorsAndShow()
        setupAppearance()
    }
}

private extension AppCoordinator {
    func setupAppearance() {
        let navigationAppearance = UINavigationBarAppearance()
        let backButtonImage = UIImage(.chevron.left).withBaselineOffset(fromBottom: 2)
        navigationAppearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        
        let navigationBar: UINavigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = .black
        
        navigationBar.standardAppearance = navigationAppearance
        navigationBar.compactAppearance = navigationAppearance
        navigationBar.scrollEdgeAppearance = navigationAppearance
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
    }
}

private extension AppCoordinator {
    func initializeTabsCoordinatorsAndShow() {
        let homeCoordinator = AppAssembly.trendingCoordinator(parent: self)
        let marketsCoordinator = AppAssembly.marketsCoordinator(parent: self)
        let newsCoordinator = AppAssembly.newsCoordinator(parent: self)
        let profileCoordinator = AppAssembly.homeCoordinator(parent: self)

        setTabsCoordinators([homeCoordinator, marketsCoordinator, newsCoordinator, profileCoordinator])
    }
    
    func authenticateStoredUserIfPossible() {
        // TODO: Remove data managers in coordinator
        guard let user = appPropertiesDataManager.user else { return }
        usersCacheDataManager.updateCurrentUser(user)
    }
}
