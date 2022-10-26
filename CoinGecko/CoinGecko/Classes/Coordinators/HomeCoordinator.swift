//
//  HomeCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class HomeCoordinator: NavigationCoordinator {
    override init(parent: Coordinator?) {
        super.init(parent: parent)
        
        showProfileScreen()
    }
}

extension HomeCoordinator {
    func showProfileScreen() {
        let (viewController, viewModel) = HomeAssembly.makeProfileScreen(resolver: self)
        viewModel.openSettingsTransition = { [weak self] in
            self?.showSettingsScreen()
        }
        
        pushViewController(viewController, animated: false)
    }
    
    func showSettingsScreen() {
        let (viewController, viewModel) = HomeAssembly.makeSettingsScreen(resolver: self)
        
        pushViewController(viewController, animated: true)
    }
}
