//
//  ComposeUserPhotoViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension ComposeUserPhotoViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services

            super.init()
        }
    }
}

// MARK: - ComposeUserPhotoViewModel+NestedTypes
extension ComposeUserPhotoViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let close: Closure.Void
    }
    
    final class Services {
//        let coins: CoinsServiceProtocol
//
//        init(coins: CoinsServiceProtocol) {
//            self.coins = coins
//        }
    }
}

extension ComposeUserPhotoViewController.ViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
    
    func didTapCompleteUserComposeButton() {
        transitions.close()
    }
}
