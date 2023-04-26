//
//  AccountWalletsViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension AccountWalletsViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        init(transitions: Transitions, services: Services) {
            self.services = services
            self.transitions = transitions
            
            super.init()
            
            fetchWallets()
        }
    }
}

// MARK: - AccountWalletsViewModel+NestedTypes
extension AccountWalletsViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        var composeWallet: (@escaping Closure.Void) -> Void
    }
    
    final class Services {
        let wallets: WalletsServiceProtocol
        
        init(wallets: WalletsServiceProtocol) {
            self.wallets = wallets
        }
    }
}

private extension AccountWalletsViewController.ViewModel {
    func fetchWallets() {
        
    }
}

extension AccountWalletsViewController.ViewModel {
    func didTapComposeWalletButton() {
        transitions.composeWallet {
            print("compose wallet finished")
        }
    }
}
