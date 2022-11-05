//
//  CoinsListViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension CoinsListViewController {
    final class ViewModel {
        private let coinsInteractor: CoinsInteractorProtocol
        
        var showCoinDetailInfoTransition: Closure.String?
        var errorHandlerClosure: Closure.APIError?
        
        let coinsViewModels = CurrentValueSubject<[CoinCell.ViewModel], Never>([])
        var coinsCount: Int { coinsViewModels.value.count }
        
        private var isSearchPerforming = false
        private var currentPage = 0

        init(coinsInteractor: CoinsInteractorProtocol) {
            self.coinsInteractor = coinsInteractor
//            coinsInteractor.coins
            
        }
        
        func fetchCoins() {
            guard !isSearchPerforming else { return }
            isSearchPerforming = true
            
            // TODO: - Refactor nextPage value calculation according to current items and remove currentPage property
            currentPage += 1
            
            ActivityIndicator.show()
            coinsInteractor.getCoins(fromCache: false,
                                     currency: "usd",
                                     page: currentPage,
                                     pageSize: 20,
                                     success: { [weak self] coins in
                guard let self = self else { return }
                self.isSearchPerforming = false
                
                self.coinsViewModels.send(
                    self.coinsViewModels.value + coins.map { coin in
                        let isPriceChangePositive = coin.priceDetails.changePercentage24h > 0
                        var priceChangeString = preciseRound(coin.priceDetails.changePercentage24h,
                                                             precision: .hundredths).description
                        priceChangeString.insert(contentsOf: isPriceChangePositive ? "+" : .empty,
                                                 at: priceChangeString.startIndex)
                        priceChangeString.insert(contentsOf: String.percent, at: priceChangeString.endIndex)

                        var currentPriceString = preciseRound(coin.priceDetails.currentPrice,
                                                              precision: .thousandths).description
                        currentPriceString.insert(contentsOf: "usd".currencySymbol, at: currentPriceString.startIndex)

                        return CoinCell.ViewModel(
                            id: coin.id,
                            imageURL: coin.imageURL,
                            name: coin.name,
                            symbol: coin.symbol.uppercased(),
                            currentPrice: currentPriceString,
                            priceChangePercentage: priceChangeString,
                            isPriceChangePositive: isPriceChangePositive
                        )
                    }
                )
                ActivityIndicator.hide()
            }, failure: { [weak self] error in
                self?.isSearchPerforming = false
                self?.errorHandlerClosure?(error)
            })
        }
        
        func cellViewModel(for indexPath: IndexPath) -> CoinCell.ViewModel {
            coinsViewModels.value[indexPath.row]
        }
        
        func didSelectCoin(at indexPath: IndexPath) {
            showCoinDetailInfoTransition?(coinsViewModels.value[indexPath.row].id)
        }
    }
}
