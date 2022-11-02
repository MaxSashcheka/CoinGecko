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
        
        showHomeScreen()
    }
}

extension HomeCoordinator {
    func showHomeScreen() {
        let (viewController, viewModel) = HomeAssembly.makeHomeScreen(resolver: self)
        viewModel.openSettingsTransition = { [weak self] in
            self?.showSettingsScreen()
        }
        viewModel.openProfileTransition = { [weak self] in
            self?.showProfileScreen()
        }
        
        pushViewController(viewController, animated: false)
    }
    
    func showSettingsScreen() {
        let (viewController, _) = HomeAssembly.makeSettingsScreen(resolver: self)
        
        pushViewController(viewController, animated: true)
    }
    
    func showProfileScreen() {
        let (viewController, _) = HomeAssembly.makeProfileScreen(resolver: self)
        
        pushViewController(viewController, animated: true)
    }
}
