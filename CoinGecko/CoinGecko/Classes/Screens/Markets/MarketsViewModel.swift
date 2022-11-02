//
//  MarketsViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension MarketsViewController {
    final class ViewModel {
        typealias DisplayMode = PageButton.ViewModel.DisplayMode
        
        private let coinsInteractor: CoinsInteractorProtocol
        
        var showCoinDetailInfoTransition: Closure.String?
        var showSearchTransition: Closure.Void?
        var errorHandlerClosure: Closure.APIError?
        
        let pageButtonsCollectionViewModel = PageButtonsCollectionView.ViewModel()
        
        let coinsViewModels = CurrentValueSubject<[CoinCell.ViewModel], Never>([])
        let changePercentage = CurrentValueSubject<Double, Never>(.zero)
        let isPriceChangePositive = CurrentValueSubject<Bool, Never>(false)
        
        var coinsCount: Int { coinsViewModels.value.count }
        
        init(coinsInteractor: CoinsInteractorProtocol) {
            self.coinsInteractor = coinsInteractor
            
            pageButtonsCollectionViewModel.buttonsViewModels.send(
                DisplayMode.allCases.map {
                    PageButton.ViewModel(title: $0.title, displayMode: $0)
                }
            )
            
            fetchGlobalData()
        }
        
        func fetchGlobalData() {
            ActivityIndicator.show()
            coinsInteractor.getGlobalData { [weak self] globalData in
                self?.isPriceChangePositive.send(globalData.previousDayChangePercentage > .zero)
                self?.changePercentage.send(globalData.previousDayChangePercentage)
            } failure: { [weak self] error in
                self?.errorHandlerClosure?(error)
            }
        }
        
        func fetchCoins(mode: DisplayMode) {
            ActivityIndicator.show()
            coinsInteractor.getCoins(fromCache: false,
                                     currency: "usd",
                                     page: 1,
                                     pageSize: 50,
                                     success: { [weak self] coins in
                // TODO: - Refactor logic for setup cell data and remove duplicating code here and in CoinsListViewController
                let filterClosure: (Coin) -> Bool = { coin in
                    switch mode {
                    case .all, .favourites: return true
                    case .gainer: return coin.priceDetails.changePercentage24h > .zero
                    case .loser: return coin.priceDetails.changePercentage24h < .zero
                    }
                }
                
                self?.coinsViewModels.send(
                    coins.filter(filterClosure).map { coin in
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
            }, failure: { [weak self] in
                self?.errorHandlerClosure?($0)
            })
        }
        
        func cellViewModel(for indexPath: IndexPath) -> CoinCell.ViewModel {
            coinsViewModels.value[indexPath.row]
        }
        
        func didSelectCoin(at indexPath: IndexPath) {
            showCoinDetailInfoTransition?(coinsViewModels.value[indexPath.row].id)
        }
        
        func didTapSearchButton() {
            showSearchTransition?()
        }
    }
}
