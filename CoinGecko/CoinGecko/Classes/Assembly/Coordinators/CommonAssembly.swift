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
    static func makeCoinDetailsScreen(resolver: Resolver,
                                      coinId: String,
                                      isAddToPortfolioEnabled: Bool) -> (CoinDetailsViewController, CoinDetailsViewModel) {
        let viewController = CoinDetailsViewController()
        let viewModel = CoinDetailsViewModel(
            coinId: coinId,
            coinsInteractor: InteractorsAssembly.makeCoinsInteractor(resolver: resolver),
            isAddToPortfolioEnabled: isAddToPortfolioEnabled
        )
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
    typealias AddCoinOverlayViewModel = AddCoinOverlayViewController.ViewModel
    static func makeAddCoinBottomSheet(resolver: Resolver,
                                       coinId: String) -> (AddCoinOverlayViewController, AddCoinOverlayViewModel) {
        let viewController = AddCoinOverlayViewController()
        let viewModel = AddCoinOverlayViewModel(
            coinId: coinId,
            coinsInteractor: InteractorsAssembly.makeCoinsInteractor(resolver: resolver)
        )
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
    typealias InAppWebBrowserViewModel = InAppWebBrowserViewController.ViewModel
    static func makeInAppWebBroserScreen(url: URL) -> (InAppWebBrowserViewController, InAppWebBrowserViewModel) {
        let viewController = InAppWebBrowserViewController(url: url)
        let viewModel = InAppWebBrowserViewModel()
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
}
