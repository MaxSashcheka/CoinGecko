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
    final class ViewModel: ScreenTransitionable, HandlersAccessible {
        private let walletId: UUID
        private let services: Services
        let transitions: Transitions
        
        let walletTitle = CurrentValueSubject<String, Never>(.empty)
        let coinsViewModels = CurrentValueSubject<[CoinCell.ViewModel], Never>([])
         
        init(walletId: UUID, transitions: Transitions, services: Services) {
            self.walletId = walletId
            self.services = services
            self.transitions = transitions
            
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
                    priceChangePercentage: L10n.AccountWallets.amount + preciseRound(Double(services.wallets.coinAmount(for: $0.id)), precision: .hundredths).description
                )
            }
        )
    }
    
    func fetchWalletData() {
        services.wallets.clearCoinsIdentifiers()
        
        services.wallets.getWallet(
            id: walletId,
            completion: { [weak self] result in
                switch result {
                case .success(let wallet):
                    self?.walletTitle.send(wallet.name)
                case .failure(let error):
                    self?.errorsHandler.handle(error: error)
                }
            }
        )
        
        activityIndicator.show()
        services.wallets.getCoinsIdentifiers(
            walletId: walletId,
            completion: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let coinsIdentifiers):
                    
                    self.services.wallets.save(coinsIdentifier: coinsIdentifiers)
                    Perform.batch(
                        coinsIdentifiers,
                        action: { [weak self] coinIdentifier, success, failure in
                            self?.services.coins.getCoinDetails(
                                id: coinIdentifier.identifier,
                                completion: { result in
                                    switch result {
                                    case .success(let coinDetails): success(coinDetails)
                                    case .failure(let error): failure(error)
                                    }
                                }
                            )
                        },
                        success: { [weak self] in
                            self?.activityIndicator.hide()
                            self?.updateCoinsViewModels(with: $0)
                        },
                        failure: self.errorsHandler.handleClosure(completion: self.activityIndicator.hideClosure)
                    )
                    
                case .failure(let error):
                    self.errorsHandler.handle(error: error, completion: self.activityIndicator.hideClosure)
                }
            }
        )
    }
}

// MARK: - WalletDetailsViewModel+TapActions
extension WalletDetailsViewController.ViewModel {
    func didTapDeleteWalletButton() {
        services.wallets.deleteWallet(
            id: walletId,
            completion: { [weak self] result in
                switch result {
                case .success(_):
                    self?.transitions.completion()
                case .failure(let error):
                    self?.errorsHandler.handle(error: error)
                }
            }
        )
    }
}

extension WalletDetailsViewController.ViewModel: PriceConvertable { }
