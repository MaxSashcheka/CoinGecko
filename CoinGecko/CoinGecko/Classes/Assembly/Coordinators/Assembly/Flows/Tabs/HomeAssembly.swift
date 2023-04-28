//
//  HomeAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

enum HomeAssembly { }

// MARK: - Screens

extension HomeAssembly {
    static func homeScreen(
        transitions: HomeViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> HomeViewController {
        let viewController = HomeViewController()
        let viewModel = HomeViewController.ViewModel(
            transitions: transitions, services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func accountWalletsScreen(
        transitions: AccountWalletsViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> AccountWalletsViewController {
        let viewController = AccountWalletsViewController()
        let viewModel = AccountWalletsViewController.ViewModel(
            transitions: transitions, services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func walletDetailsScreen(
        walletId: UUID,
        transitions: WalletDetailsViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> WalletDetailsViewController {
        let viewController = WalletDetailsViewController()
        let viewModel = WalletDetailsViewController.ViewModel(
            walletId: walletId,
            transitions: transitions,
            services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
}

// MARK: - DI

extension HomeViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(auth: ServicesAssembly.auth(resolver: resolver),
             users: ServicesAssembly.users(resolver: resolver))
    }
}

extension AccountWalletsViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(wallets: ServicesAssembly.wallets(resolver: resolver))
    }
}

extension WalletDetailsViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(wallets: ServicesAssembly.wallets(resolver: resolver),
             coins: ServicesAssembly.coins(resolver: resolver))
    }
}
