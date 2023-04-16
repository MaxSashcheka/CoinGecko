//
//  TrendingAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core

enum TrendingAssembly: Assembly { }

// MARK: - Screens

extension TrendingAssembly {
    static func coinsListScreen(
        transitions: TrendingViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> TrendingViewController {
        let viewController = TrendingViewController()
        let viewModel = TrendingViewController.ViewModel(
            transitions: transitions, services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
}

// MARK: - DI

extension TrendingViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(coins: ServicesAssembly.coins(resolver: resolver))
    }
}

