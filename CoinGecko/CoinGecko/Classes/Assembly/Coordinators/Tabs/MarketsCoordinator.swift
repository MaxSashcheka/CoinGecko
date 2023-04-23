//
//  MarketsCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class MarketsCoordinator: NavigationCoordinator {
    override init(parent: Coordinator?) {
        super.init(parent: parent)
        
        showMarketsScreen()
    }
}

extension MarketsCoordinator {
    func showMarketsScreen() {
        let transitions = MarketsViewController.ViewModel.Transitions(
            coinDetails: { [weak self] in self?.showCoinDetailsCoordinator(coinId: $0) },
            search: { [weak self] in self?.showSearchScreen() }
        )
        let screen = MarketsAssembly.marketsScreen(
            transitions: transitions,
            resolver: self
        )
        
        pushViewController(screen, animated: false)
    }
    
    func showSearchScreen() {
        let transitions = SearchViewController.ViewModel.Transitions(
            coinDetails: { [weak self] in
                self?.showCoinDetailsCoordinator(coinId: $0, isAddToPortfolioEnabled: false)
            }
        )
        let screen = MarketsAssembly.searchScreen(
            transitions: transitions,
            resolver: self
        )
        
        pushViewController(screen, animated: true)
    }
    
    func showCoinDetailsCoordinator(coinId: String, isAddToPortfolioEnabled: Bool = true) {
        let transitions = CoinDetailsCoordinator.Transitions(
            close: { [weak self] in self?.dismissModalCoordinator() }
        )
        let coordinator = CoinDetailsCoordinator(
            parent: self,
            transitions: transitions,
            coinId: coinId,
            isAddToPortfolioEnabled: isAddToPortfolioEnabled
        )
        presentModal(coordinator: coordinator, presentationStyle: .fullScreen)
    }
}
