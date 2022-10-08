//
//  MarketsAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class MarketsAssembly { }

// MARK: - Screens
extension MarketsAssembly {
    typealias MarketsViewModel = MarketsViewController.ViewModel
    static func makeMarketsScreen(resolver: Resolver) -> (MarketsViewController, MarketsViewModel) {
        let viewController = MarketsViewController()
        let viewModel = MarketsViewModel(
            coinsInteractor: InteractorsAssembly.makeCoinsInteractor(resolver: resolver)
        )
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
}
