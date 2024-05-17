//
//  CoinDetailsCoordinator.swift
//  CoinGecko
//
//  Created by Max Sashcheka on 30.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class CoinDetailsCoordinator: NavigationCoordinator {
    struct Transitions {
        let close: Transition
    }
    
    private let transitions: Transitions
    
    init(parent: Coordinator?,
         transitions: Transitions,
         coinId: String) {
        self.transitions = transitions
        
        super.init(parent: parent)
        
        showCoinDetailInfoScreen(coinId: coinId)
    }
}

// MARK: - CoinDetailsCoordinator+SreensAssembly
extension CoinDetailsCoordinator {
    func showCoinDetailInfoScreen(coinId: String) {
        let transitions = CoinDetailsViewController.ViewModel.Transitions(
            close: { [weak self] in self?.transitions.close() },
            browser: showInAppWebBrowserTransition,
            addToWallet: { [weak self] in self?.showAddCoinCoordinator(coinId: coinId) }
        )
        
        let screen = CommonAssembly.coinDetailsScreen(
            transitions: transitions,
            resolver: self,
            coinId: coinId
        )

        pushViewController(screen, animated: false)
    }
}
// MARK: - CoinDetailsCoordinator+InAppWebBrowserPresentable
extension CoinDetailsCoordinator: InAppWebBrowserPresentable { }

// MARK: - CoinDetailsCoordinator+AddCoinCoordinatorPresentable
extension CoinDetailsCoordinator: AddCoinCoordinatorPresentable { }
