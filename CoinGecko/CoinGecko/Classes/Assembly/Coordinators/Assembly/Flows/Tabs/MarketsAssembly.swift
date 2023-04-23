//
//  MarketsAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core

enum MarketsAssembly { }

// MARK: - Screens

extension MarketsAssembly {
    static func marketsScreen(
        transitions: MarketsViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> MarketsViewController {
        let viewController = MarketsViewController()
        let viewModel = MarketsViewController.ViewModel(
            transitions: transitions, services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func searchScreen(
        transitions: SearchViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> SearchViewController {
        let viewController = SearchViewController()
        let viewModel = SearchViewController.ViewModel(
            transitions: transitions, services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
}

// MARK: - DI

extension MarketsViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(coins: ServicesAssembly.coins(resolver: resolver))
    }
}

extension SearchViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(coins: ServicesAssembly.coins(resolver: resolver))
    }
}
