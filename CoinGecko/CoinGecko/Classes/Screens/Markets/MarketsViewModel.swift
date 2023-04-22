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
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable, PriceConvertable {
        typealias DisplayMode = PageButton.ViewModel.DisplayMode

        private let services: Services
        let transitions: Transitions
        
        let pageButtonsCollectionViewModel = PageButtonsCollectionView.ViewModel()
        
        let coinsViewModels = CurrentValueSubject<[CoinCell.ViewModel], Never>([])
        let changePercentage = CurrentValueSubject<Double, Never>(.zero)
        let isPriceChangePositive = CurrentValueSubject<Bool, Never>(false)
        let favouriteCoins = CurrentValueSubject<[Coin], Never>([])
        
        private var selectedMode: DisplayMode { pageButtonsCollectionViewModel.selectedMode.value }
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services

            super.init()
            
            pageButtonsCollectionViewModel.buttonsViewModels.send(
                DisplayMode.allCases.map {
                    PageButton.ViewModel(title: $0.title, displayMode: $0)
                }
            )
            
            fetchGlobalData()
        }
    }
}

// MARK: - MarketsViewModel+NestedTypes
extension MarketsViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let coinDetails: Closure.String
        let search: Transition
    }
    
    final class Services {
        let coins: CoinsServiceProtocol
        
        init(coins: CoinsServiceProtocol) {
            self.coins = coins
        }
    }
}

// MARK: - MarketsViewModel+Fetch
extension MarketsViewController.ViewModel {    
    func fetchGlobalData() {
        ActivityIndicator.show()
        services.coins.getGlobalData(success: { [weak self] globalData in
            self?.isPriceChangePositive.send(globalData.previousDayChangePercentage > .zero)
            self?.changePercentage.send(globalData.previousDayChangePercentage)
            ActivityIndicator.hide()
        }, failure: { [weak self] error in
            ActivityIndicator.hide()
            self?.errorHandlerClosure?(error)
        })
    }
    
    func fetchCoins() {
        let mode = selectedMode
        services.coins.getCoins(fromCache: true,
                                 currency: "usd",
                                 page: 1,
                                 pageSize: 50,
                                 success: { [weak self] coins in
            guard let self = self else { return }
            if mode == .favourites {
                self.coinsViewModels.send(
                    self.makeCoinViewModels(from: self.favouriteCoins.value)
                )
                return
            }
            
            let filterClosure: (Coin) -> Bool = { coin in
                switch mode {
                case .all: return true
                case .gainer: return coin.priceDetails.changePercentage24h > .zero
                case .loser: return coin.priceDetails.changePercentage24h < .zero
                default:
                    assertionFailure("Impossible state")
                    return true
                }
            }
            
            self.coinsViewModels.send(
                self.makeCoinViewModels(from: coins.filter(filterClosure))
            )
        }, failure: { [weak self] error in
            self?.errorHandlerClosure?(error)
        })
    }
}

// MARK: - MarketsViewModel+MakeViewModels
private extension MarketsViewController.ViewModel {
    func makeCoinViewModels(from coins: [Coin]) -> [CoinCell.ViewModel] {
        coins.map { coin in
            let isPriceChangePositive = coin.priceDetails.changePercentage24h > 0
            let priceChangeString = roundedValuePriceChangeString(
                coin.priceDetails.changePercentage24h,
                isChangePositive: isPriceChangePositive
            )

            return CoinCell.ViewModel(
                id: coin.id,
                imageURL: coin.imageURL,
                name: coin.name,
                symbol: coin.symbol.uppercased(),
                currentPrice: roundedValueString(coin.priceDetails.currentPrice),
                priceChangePercentage: priceChangeString,
                isPriceChangePositive: isPriceChangePositive
            )
        }
    }
}

// MARK: - MarketsViewModel+TapActions
extension MarketsViewController.ViewModel {
    func didTapSearchButton() {
        transitions.search()
    }
}

// MARK: - MarketsViewModel+TableMethods
extension MarketsViewController.ViewModel {
    var coinsCount: Int { coinsViewModels.value.count }
    
    func cellViewModel(for indexPath: IndexPath) -> CoinCell.ViewModel {
        coinsViewModels.value[indexPath.row]
    }
    
    func didSelectCoin(at indexPath: IndexPath) {
        transitions.coinDetails(coinsViewModels.value[indexPath.row].id)
    }
}
