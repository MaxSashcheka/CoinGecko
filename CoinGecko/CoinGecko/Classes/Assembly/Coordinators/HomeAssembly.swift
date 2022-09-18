//
//  HomeAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

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
}
