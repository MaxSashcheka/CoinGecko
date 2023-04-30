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
        let coinsViewModels = CurrentValueSubject<[CoinCell.ViewModel], Never>([])
         
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

// MARK: - WalletDetailsViewModel+TableMethods
extension WalletDetailsViewController.ViewModel {
    var coinsCount: Int { coinsViewModels.value.count }
    
    func cellViewModel(for indexPath: IndexPath) -> CoinCell.ViewModel {
        coinsViewModels.value[indexPath.row]
    }
}

// MARK: - WalletDetailsViewModel+FetchData
private extension WalletDetailsViewController.ViewModel {
    func updateCoinsViewModels(with coins: [CoinDetails]) {        
        coinsViewModels.send(
            coins.map {
                CoinCell.ViewModel(
                    id: $0.id,
                    imageURL: $0.imageURL,
                    name: $0.name,
                    symbol: $0.symbol.uppercased(),
                    currentPrice: roundedValueString($0.currentPrice),
                    priceChangePercentage: "Amount " + preciseRound(Double(services.wallets.coinAmount(for: $0.id)), precision: .hundredths).description
                )
            }
        )
    }
    
    func fetchWalletData() {
        services.wallets.clearCoinsIdentifiers()
        
        services.wallets.getWallet(
            id: walletId,
            success: { [weak self] in self?.walletTitle.send($0.name) },
            failure: { [weak self] in self?.errorHandlerClosure?($0) }
        )
        
        ActivityIndicator.show()
        services.wallets.getCoinsIdentifiers(
            walletId: walletId,
            success: { [weak self] coinsIdentifiers in
                self?.services.wallets.save(coinsIdentifier: coinsIdentifiers)
                Perform.batch(
                    coinsIdentifiers,
                    action: { [weak self] coinIdentifier, success, failure in
                        self?.services.coins.getCoinDetails(
                            id: coinIdentifier.identifier,
                            success: success,
                            failure: failure
                        )
                    },
                    success: { [weak self] in
                        ActivityIndicator.hide()
                        self?.updateCoinsViewModels(with: $0)
                    },
                    failure: { [weak self] in
                        ActivityIndicator.hide()
                        self?.errorHandlerClosure?($0)
                    }
                )
            },
            failure: { [weak self] in
                self?.errorHandlerClosure?($0)
                ActivityIndicator.hide()
            }
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

extension WalletDetailsViewController.ViewModel: PriceConvertable { }
