//
//  AddCoinCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core
import Utils

final class AddCoinCoordinator: NavigationCoordinator {
    struct Transitions {
        let close: Transition
    }
    
    private let transitions: Transitions
    
    init(coinId: String,
         parent: Coordinator?,
         transitions: Transitions) {
        self.transitions = transitions
        
        super.init(parent: parent)
        
        showAddCoinScreen(coinId: coinId)
    }
}

extension AddCoinCoordinator {
    func showAddCoinScreen(coinId: String) {
        let transitions = AddCoinViewController.ViewModel.Transitions(
            close: { [weak self] in self?.transitions.close() }
        )
        let screen = CommonAssembly.addCoinScreen(
            transitions: transitions,
            resolver: self
        )
        pushViewController(screen, animated: false)
    }
}
