//
//  ComposeUserInfoViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension ComposeUserInfoViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services

            super.init()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.transitions.composeUserPhoto()
            }
        }
    }
}

// MARK: - ComposeUserInfoViewModel+NestedTypes
extension ComposeUserInfoViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let close: Closure.Void
        let composeUserPhoto: Closure.Void
    }
    
    final class Services {
//        let coins: CoinsServiceProtocol
//
//        init(coins: CoinsServiceProtocol) {
//            self.coins = coins
//        }
    }
}

extension ComposeUserInfoViewController.ViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
    
    func didTapShowComposeUserPhotoButton() {
        transitions.composeUserPhoto()
    }
}
