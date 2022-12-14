//
//  RootCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import SafeSFSymbols
import Utils
import UIKit

final class RootCoordinator: TabCoordinator {

    override func registerContent() {
        register(DataSourcesAssembly.makeCoreDataSource())
        register(CacheDataManagerAssembly.makeCoinsCacheDataManager(resolver: self))
        register(RootAssembly.makeExternalLinkBuilder())
    }

    func start(at window: UIWindow?) {
        assert(window.nonNil, "Root Window is nil")
        window?.rootViewController = baseViewController
        window?.makeKeyAndVisible()

        initializeTabsCoordinatorsAndShow()
        setupAppearance()
    }
}

private extension RootCoordinator {
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

private extension RootCoordinator {
    func initializeTabsCoordinatorsAndShow() {
        let homeCoordinator = RootAssembly.makeTrendingCoordinator(parent: self)
        let marketsCoordinator = RootAssembly.makeMarketsCoordinator(parent: self)
        let profileCoordinator = RootAssembly.makeHomeCoordinator(parent: self)

        setTabsCoordinators([homeCoordinator, marketsCoordinator, profileCoordinator])
    }
}
