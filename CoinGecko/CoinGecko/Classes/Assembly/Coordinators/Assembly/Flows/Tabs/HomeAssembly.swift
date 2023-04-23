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
    
}

// MARK: - DI

extension HomeViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(coins: ServicesAssembly.coins(resolver: resolver))
    }
}

