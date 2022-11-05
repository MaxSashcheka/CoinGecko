//
//  HomeViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension HomeViewController {
    final class ViewModel {
        private let coinsInteractor: CoinsInteractorProtocol
        
        init(coinsInteractor: CoinsInteractorProtocol) {
            self.coinsInteractor = coinsInteractor
        }
        
        var openSettingsTransition: Closure.Void?
        var openProfileTransition: Closure.Void?
        var errorHandlerClosure: Closure.APIError?
        
        let navigationBarViewModel = HomeNavigationBarView.ViewModel()
        let networthCardViewModel = NetworhCardView.ViewModel()
        
        let coinsViewModels = CurrentValueSubject<[NetworthCoinCell.ViewModel], Never>([])
        var coinsCount: Int { coinsViewModels.value.count }
        
        func fetchPortfolioCoins() {
            coinsInteractor.getStoredCoins(success: { [weak self] coins in
                self?.coinsViewModels.send(
                    coins.map { coin in
                        let isPriceChangePositive = coin.priceDetails.changePercentage24h > 0
                        var priceChangeString = preciseRound(coin.priceDetails.changePercentage24h,
                                                             precision: .hundredths).description
                        priceChangeString.insert(contentsOf: isPriceChangePositive ? "+" : .empty,
                                                 at: priceChangeString.startIndex)
                        priceChangeString.insert(contentsOf: String.percent, at: priceChangeString.endIndex)

                        var currentPriceString = preciseRound(coin.priceDetails.currentPrice,
                                                              precision: .thousandths).description
                        currentPriceString.insert(contentsOf: "usd".currencySymbol, at: currentPriceString.startIndex)
                        
                        return NetworthCoinCell.ViewModel(
                            id: coin.id,
                            imageURL: coin.imageURL,
                            name: coin.name,
                            symbol: coin.symbol.uppercased(),
                            currentPrice: currentPriceString,
                            priceChangePercentage: priceChangeString,
                            isPriceChangePositive: isPriceChangePositive,
                            portfolioCount: coin.amount,
                            portfolioPrice: coin.amount * coin.priceDetails.currentPrice
                        )
                    }
                )
            }, failure: { [weak self] _ in
                // TODO: - Fix this error closure
                self?.errorHandlerClosure?(.corruptedResponse)
            })
            
            coinsViewModels.send(
                (0...15).map { _ in
                    NetworthCoinCell.ViewModel(id: "bitcoin",
                                               imageURL: nil,
                                               name: "Bitcoin",
                                               symbol: "BTC",
                                               currentPrice: "18023",
                                               priceChangePercentage: "-12.3%",
                                               isPriceChangePositive: false,
                                               portfolioCount: 1.23,
                                               portfolioPrice: 23456)
                }
            )
        }
        
        func cellViewModel(for indexPath: IndexPath) -> NetworthCoinCell.ViewModel {
            coinsViewModels.value[indexPath.row]
        }
        
        func didSelectCoin(at indexPath: IndexPath) {
//            showCoinDetailInfoTransition?(coinsViewModels.value[indexPath.row].id)
        }
    }
}

extension HomeViewController.ViewModel {
    func didTapSettingsButton() {
        openSettingsTransition?()
    }
    
    func didTapProfileButton() {
        openProfileTransition?()
    }
}
