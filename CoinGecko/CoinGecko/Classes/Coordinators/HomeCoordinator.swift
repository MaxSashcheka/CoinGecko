//
//  HomeCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

class HomeCoordinator: NavigationCoordinator {
    override init(parent: Coordinator?) {
        super.init(parent: parent)
        
        showCoinsListScreen()
    }
}

private extension HomeCoordinator {
    func showCoinsListScreen() -> () {
        let (viewController, viewModel) = HomeAssembly.makeCoinsListScreen(resolver: self)
        
        pushViewController(viewController, animated: false)
    }
}

