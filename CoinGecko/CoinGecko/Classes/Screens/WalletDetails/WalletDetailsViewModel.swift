//
//  WalletDetailsViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension WalletDetailsViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let walletId: UUID
        private let services: Services
        let transitions: Transitions
        
        let walletTitle = CurrentValueSubject<String, Never>(.empty)
         
        init(walletId: UUID, transitions: Transitions, services: Services) {
            self.walletId = walletId
            self.services = services
            self.transitions = transitions
            
            super.init()
            
            fetchWalletData()
        }
    }
}

// MARK: - WalletDetailsViewModel+NestedTypes
extension WalletDetailsViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let completion: Closure.Void
    }
    
    final class Services {
        let wallets: WalletsServiceProtocol
        let coins: CoinsServiceProtocol
        
        init(wallets: WalletsServiceProtocol,
             coins: CoinsServiceProtocol) {
            self.wallets = wallets
            self.coins = coins
        }
    }
}

// MARK: - WalletDetailsViewModel+FetchData
private extension WalletDetailsViewController.ViewModel {
    func fetchWalletData() {
        services.wallets.getWallet(
            id: walletId,
            success: { [weak self] in self?.walletTitle.send($0.name) },
            failure: { [weak self] in self?.errorHandlerClosure?($0) }
        )
        
        services.wallets.getCoinsIdentifiers(
            walletId: walletId,
            success: { [weak self] coinsIdentifiers in
                print(coinsIdentifiers)
            },
            failure: { [weak self] in self?.errorHandlerClosure?($0) }
        )
    }
}

// MARK: - WalletDetailsViewModel+TapActions
extension WalletDetailsViewController.ViewModel {
    func didTapDeleteWalletButton() {
        services.wallets.deleteWallet(
            id: walletId,
            success: { [weak self] in self?.transitions.completion() },
            failure: { [weak self] in self?.errorHandlerClosure?($0) }
        )
    }
}
