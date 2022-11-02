//
//  CommonAssembly.swift
//  CoinGecko
//
//  Created by Max Sashcheka on 30.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class CommonAssembly: Assembly { }

// MARK: - Screens
extension CommonAssembly {
    typealias CoinDetailsViewModel = CoinDetailsViewController.ViewModel
    static func makeCoinDetailsScreen(resolver: Resolver, coinId: String) -> (CoinDetailsViewController, CoinDetailsViewModel) {
        let viewController = CoinDetailsViewController()
        let viewModel = CoinDetailsViewModel(
            coinId: coinId,
            coinsInteractor: InteractorsAssembly.makeCoinsInteractor(resolver: resolver)
        )
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
    typealias AddCoinOverlayViewModel = AddCoinOverlayViewController.ViewModel
    static func makeAddCoinBottomSheet() -> (AddCoinOverlayViewController, AddCoinOverlayViewModel) {
        let viewController = AddCoinOverlayViewController()
        let viewModel = AddCoinOverlayViewModel()
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
}
