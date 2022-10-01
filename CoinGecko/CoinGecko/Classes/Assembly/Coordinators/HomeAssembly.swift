//
//  HomeAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class HomeAssembly: Assembly { }

// MARK: - Screens
extension HomeAssembly {
    typealias CoinsListViewModel = CoinsListViewController.ViewModel
    static func makeCoinsListScreen(resolver: Resolver) -> (CoinsListViewController, CoinsListViewModel) {
        let viewController = CoinsListViewController()
        let viewModel = CoinsListViewModel(
            coinsInteractor: InteractorsAssembly.makeCoinsInteractor(resolver: resolver)
        )
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
    typealias CoinDetailsViewModel = CoinDetailsViewController.ViewModel
    static func makeCoinDetailsScreen(resolver: Resolver, coin: Coin) -> (CoinDetailsViewController, CoinDetailsViewModel) {
        let viewController = CoinDetailsViewController()
        let viewModel = CoinDetailsViewModel(
            coin: coin,
            coinsInteractor: InteractorsAssembly.makeCoinsInteractor(resolver: resolver)
        )
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
}
