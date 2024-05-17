//
//  AddCoinCoordinatorPresentable.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

protocol AddCoinCoordinatorPresentable {
    func showAddCoinCoordinator(coinId: String)
}

extension AddCoinCoordinatorPresentable where Self: NavigationCoordinator {
    func showAddCoinCoordinator(coinId: String) {
        let transitions = AddCoinCoordinator.Transitions(
            close: { [weak self] in self?.dismissModalCoordinator() }
        )
        let coordinator = AddCoinCoordinator(
            coinId: coinId,
            parent: self,
            transitions: transitions
        )
        presentModal(coordinator: coordinator, presentationStyle: .fullScreen)
    }
    
    var showAddCoinCoordinatorTransition: Closure.String {
        { [weak self] in self?.showAddCoinCoordinator(coinId: $0) }
    }
}
