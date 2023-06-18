//
//  TrendingViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension TrendingViewController {
    final class ViewModel: ScreenTransitionable, PriceConvertable, HandlersAccessible {
        private let services: Services
        let transitions: Transitions
        
        let coinsViewModels = CurrentValueSubject<[CoinCell.ViewModel], Never>([])
        
        private var isSearchPerforming = false
        private var currentPage = 0

        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services
        }
    }
}

// MARK: - TrendingViewModel+NestedTypes
extension TrendingViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let coinDetails: Closure.String
        let composeUser: (@escaping Closure.Void) -> Void
    }
    
    final class Services {
        let coins: CoinsServiceProtocol
        
        init(coins: CoinsServiceProtocol) {
            self.coins = coins
        }
    }
}

// MARK: - TrendingViewModel+TableMethods
extension TrendingViewController.ViewModel {
    var coinsCount: Int { coinsViewModels.value.count }
    
    func cellViewModel(for indexPath: IndexPath) -> CoinCell.ViewModel {
        coinsViewModels.value[indexPath.row]
    }
    
    func didSelectCoin(at indexPath: IndexPath) {
        transitions.coinDetails(coinsViewModels.value[indexPath.row].id)
    }
}

// MARK: - TrendingViewModel+Fetch
extension TrendingViewController.ViewModel {
    func fetchCoins() {
        guard !isSearchPerforming else { return }
        isSearchPerforming = true
        
        currentPage += 1
        
        activityIndicator.show()
        services.coins.getCoins(fromCache: false,
                                currency: "usd",
                                page: currentPage,
                                pageSize: 20,
                                success: { [weak self] coins in
            guard let self = self else { return }
            self.isSearchPerforming = false
            
            self.coinsViewModels.send(
                self.coinsViewModels.value + coins.map { coin in
                    let isPriceChangePositive = coin.priceDetails.changePercentage24h > .zero
                    let priceChangeString = self.roundedValuePriceChangeString(
                        coin.priceDetails.changePercentage24h,
                        isChangePositive: isPriceChangePositive
                    )
                    
                    return CoinCell.ViewModel(
                        id: coin.id,
                        imageURL: coin.imageURL,
                        name: coin.name,
                        symbol: coin.symbol.uppercased(),
                        currentPrice: self.roundedValueString(coin.priceDetails.currentPrice),
                        priceChangePercentage: priceChangeString,
                        isPriceChangePositive: isPriceChangePositive
                    )
                }
            )
            self.activityIndicator.hide()
        }, failure: errorsHandler.handleClosure(completion: { [weak self] in
            self?.isSearchPerforming = false
            self?.activityIndicator.hide()
            self?.currentPage -= 1
            })                      
        )
    }
}
