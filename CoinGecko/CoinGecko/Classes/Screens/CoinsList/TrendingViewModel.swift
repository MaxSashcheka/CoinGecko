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
    final class ViewModel: ErrorHandableViewModel {
        private let coinsInteractor: CoinsInteractorProtocol
        
        var showCoinDetailInfoTransition: Closure.String?
        
        let coinsViewModels = CurrentValueSubject<[CoinCell.ViewModel], Never>([])
        
        private var isSearchPerforming = false
        private var currentPage = 0

        init(coinsInteractor: CoinsInteractorProtocol) {
            self.coinsInteractor = coinsInteractor

            super.init()
        }
    }
}

// MARK: - TrendingViewController.ViewModel+TableMethods
extension TrendingViewController.ViewModel {
    var coinsCount: Int { coinsViewModels.value.count }
    
    func cellViewModel(for indexPath: IndexPath) -> CoinCell.ViewModel {
        coinsViewModels.value[indexPath.row]
    }
    
    func didSelectCoin(at indexPath: IndexPath) {
        showCoinDetailInfoTransition?(coinsViewModels.value[indexPath.row].id)
    }
}

// MARK: - TrendingViewController.ViewModel+Fetch
extension TrendingViewController.ViewModel {
    func fetchCoins() {
        guard !isSearchPerforming else { return }
        isSearchPerforming = true
        
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
                    let priceChangeString = StringConverter.roundedValuePriceChangeString(
                        coin.priceDetails.changePercentage24h,
                        isChangePositive: isPriceChangePositive
                    )
                    
                    return CoinCell.ViewModel(
                        id: coin.id,
                        imageURL: coin.imageURL,
                        name: coin.name,
                        symbol: coin.symbol.uppercased(),
                        currentPrice: StringConverter.roundedValueString(coin.priceDetails.currentPrice),
                        priceChangePercentage: priceChangeString,
                        isPriceChangePositive: isPriceChangePositive
                    )
                }
            )
            ActivityIndicator.hide()
        }, failure: { [weak self] in
            self?.isSearchPerforming = false
            self?.errorHandlerClosure($0)
        })
    }
}
