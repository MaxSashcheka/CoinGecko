//
//  CoinDetailsViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension CoinDetailsViewController {
    final class ViewModel {
        enum RangeButtonConfig: CaseIterable {
            case hour, day, week, month, halfYear, year, all
        }
        
        private let coinsInteractor: CoinsInteractorProtocol
        private let coin: Coin
        
        var closeTransition: Closure.Void?
        var errorHandlerClosure: Closure.APIError?
        
        let navigationBarViewModel = CoinDetailsNavigationBarView.ViewModel()
        let chartViewModel = ChartView.ViewModel()
        let buttonsCollectionViewModel = ButtonsCollectionView.ViewModel()
        
        let currentPrice = CurrentValueSubject<String, Never>(.empty)
        let priceChange = CurrentValueSubject<String, Never>(.empty)
        let isPriceChangePositive = CurrentValueSubject<Bool, Never>(false)
        
        init(coin: Coin, coinsInteractor: CoinsInteractorProtocol) {
            self.coin = coin
            self.coinsInteractor = coinsInteractor
            
            navigationBarViewModel.title.send(coin.name)
            navigationBarViewModel.description.send("(\(coin.symbol.uppercased()))")
            navigationBarViewModel.imageURL.send(coin.imageURL)
            
            var currentPriceText = preciseRound(coin.priceDetails.currentPrice,
                                                precision: .thousandths).description
            currentPriceText.insert(contentsOf: "usd".currencySymbol, at: currentPriceText.startIndex)
            currentPrice.send(currentPriceText)
            
            
            
            buttonsCollectionViewModel.buttonsViewModels.send(
                RangeButtonConfig.allCases.map {
                    RangePickerButton.ViewModel(title: $0.title, offsetTimeInterval: $0.timeInterval)
                }
            )
            
            fetchCoinDetails(for: .hour)
        }
        
        func fetchCoinDetails(for timeInterval: TimeInterval) {
            ActivityIndicator.show()
            coinsInteractor.getCoinMarketChart(id: coin.id, currency: "usd",
                                               startTimeInterval: timeInterval.offsetFromCurrentTime,
                                               endTimeInterval: .intervalSince1970,
                                               success: { [weak self] chartData in
                guard let self = self else { return }
                self.chartViewModel.dataSubject.send(
                    chartData.prices.map { CGFloat($0) }
                )
                
                let chartDataFirstPrice = chartData.prices.first ?? .zero
                let isPriceChangePositive = self.coin.priceDetails.currentPrice > chartDataFirstPrice
                var priceChangeText = preciseRound(
                    self.coin.priceDetails.currentPrice - chartDataFirstPrice,
                    precision: .thousandths
                ).description
                priceChangeText.insert(contentsOf: isPriceChangePositive ? "+" : .empty,
                                       at: priceChangeText.startIndex)
                
                let priceChangePercentage: Double
                if self.coin.priceDetails.currentPrice > chartDataFirstPrice {
                    priceChangePercentage = preciseRound(
                        (self.coin.priceDetails.currentPrice / chartDataFirstPrice - 1) * 100,
                        precision: .hundredths
                    )
                } else {
                    priceChangePercentage = preciseRound(
                        (chartDataFirstPrice / self.coin.priceDetails.currentPrice - 1) * 100,
                        precision: .hundredths
                    )
                }
                
                priceChangeText.append(" (\(priceChangePercentage) %)")
                
                self.priceChange.send(priceChangeText)
                self.isPriceChangePositive.send(isPriceChangePositive)
                
                ActivityIndicator.hide()
            }, failure: { [weak self] error in
                self?.errorHandlerClosure?(error)
                ActivityIndicator.hide()
            })
        }
        
        func didTapCloseButton() {
            closeTransition?()
        }
    }
}

extension CoinDetailsViewController.ViewModel.RangeButtonConfig {
    var title: String {
        switch self {
        case .hour: return "1 H"
        case .day: return "24 H"
        case .week: return "1 W"
        case .month: return "1 M"
        case .halfYear: return "6 M"
        case .year: return "1 Y"
        case .all: return "All"
        }
    }
    
    var timeInterval: TimeInterval {
        switch self {
        case .hour: return .hour
        case .day: return .day
        case .week: return .week
        case .month: return .month
        case .halfYear: return .halfYear
        case .year: return .year
        case .all: return .intervalSince1970
        }
    }
}
