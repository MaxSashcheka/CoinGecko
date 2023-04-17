//
//  HomeCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class TrendingCoordinator: NavigationCoordinator {
    override init(parent: Coordinator?) {
        super.init(parent: parent)
        
        showTrendingScreen()
    }
}

extension TrendingCoordinator {
    func showTrendingScreen() {
        let transitions = TrendingViewController.ViewModel.Transitions(
            coinDetails: { [weak self] in self?.showCoinDetailsCoordinator(coinId: $0) },
            composeUser: { [weak self] in self?.showComposeUserCoordinator() }
        )
        let screen = TrendingAssembly.trendingScreen(transitions: transitions, resolver: self)

        pushViewController(screen, animated: false)
    }
    
    func showComposeUserCoordinator() {
        let transitions = ComposeUserCoordinator.Transitions(
            close: { [weak self] in self?.dismissModalCoordinator() }
        )
        let coordinator = ComposeUserCoordinator(parent: self, transitions: transitions)
        
        presentModal(coordinator: coordinator, presentationStyle: .fullScreen)
    }
    
    func showCoinDetailsCoordinator(coinId: String) {
        let transitions = CoinDetailsCoordinator.Transitions(
            close: { [weak self] in self?.dismissModalCoordinator() }
        )
        let coordinator = CoinDetailsCoordinator(
            parent: self,
            transitions: transitions,
            coinId: coinId
        )
        presentModal(coordinator: coordinator, presentationStyle: .fullScreen)
    }
}