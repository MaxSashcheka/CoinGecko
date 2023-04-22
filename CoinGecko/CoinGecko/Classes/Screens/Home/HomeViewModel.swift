//
//  HomeViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension HomeViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable, PriceConvertable {
        private typealias Texts = L10n.Home.NetworthCard.Status
        
        private let services: Services
        let transitions: Transitions
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services
        }
    }
}

// MARK: - HomeViewModel+NestedTypes
extension HomeViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        
    }
    
    final class Services {
        let coins: CoinsServiceProtocol
        
        init(coins: CoinsServiceProtocol) {
            self.coins = coins
        }
    }
}
