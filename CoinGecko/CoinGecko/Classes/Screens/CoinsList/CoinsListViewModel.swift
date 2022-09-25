//
//  CoinsListViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import RxCocoa
import RxSwift
import Utils

extension CoinsListViewController {
    final class ViewModel {
        private let coinsInteractor: CoinsInteractorProtocol
        
        var showCoinDetailInfoTransition: Closure.String?
        var errorHandlerClosure: NetworkRouterErrorClosure?
        
        let coinsViewModels = BehaviorRelay<[CoinCell.ViewModel]>(value: [])
        
        var coinsCount: Int { coinsViewModels.value.count }

        init(coinsInteractor: CoinsInteractorProtocol) {
            self.coinsInteractor = coinsInteractor
        }
        
        func fetchCoins() {
            // TODO: - Remove hardcoded currency string
            
            ActivityIndicator.show()
            coinsInteractor.getCoins(currency: "usd", page: 1, pageSize: 20, success: { [weak self] coins in
                self?.coinsViewModels.accept(
                    coins.map { coin in
                        let isPriceChangePositive = coin.priceChangePercentage24h > 0
                        var priceChangeString = preciseRound(coin.priceChangePercentage24h,
                                                             precision: .hundredths).description
                        priceChangeString.insert(contentsOf: isPriceChangePositive ? "+" : .empty,
                                                 at: priceChangeString.startIndex)
                        priceChangeString.insert(contentsOf: String.percent, at: priceChangeString.endIndex)

                        var currentPriceString = preciseRound(coin.currentPrice,
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
                self?.errorHandlerClosure?(error)
            })
        }
        
        func cellViewModel(for indexPath: IndexPath) -> CoinCell.ViewModel {
            coinsViewModels.value[indexPath.row]
        }
        
        func didSelectCoin(at indexPath: IndexPath) {
            let coinId = coinsViewModels.value[indexPath.row].id
            showCoinDetailInfoTransition?(coinId)
        }
    }
}
