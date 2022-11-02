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
        private let coinId: String
        
        var closeTransition: Closure.Void?
        var openBottomSheetTransition: Closure.Void?
        var errorHandlerClosure: Closure.APIError?
        
        let navigationBarViewModel = CoinDetailsNavigationBarView.ViewModel()
        let chartViewModel = ChartView.ViewModel()
        let buttonsCollectionViewModel = ButtonsCollectionView.ViewModel()
        
        let currentPrice = CurrentValueSubject<Double, Never>(.zero)
        let currentPriceText = CurrentValueSubject<String, Never>(.empty)
        let priceChangeText = CurrentValueSubject<String, Never>(.empty)
        let isPriceChangePositive = CurrentValueSubject<Bool, Never>(false)
        
        init(coinId: String, coinsInteractor: CoinsInteractorProtocol) {
            self.coinId = coinId
            self.coinsInteractor = coinsInteractor
            
            buttonsCollectionViewModel.buttonsViewModels.send(
                RangeButtonConfig.allCases.map {
                    RangePickerButton.ViewModel(title: $0.title, offsetTimeInterval: $0.timeInterval)
                }
            )
            
            fetchCoinDetails()
            fetchCoinChartData(for: .hour)
        }
        
        func fetchCoinDetails() {
            coinsInteractor.getCoinDetails(id: coinId,
                                           success: { [weak self] coinDetails in
                guard let self = self else { return }
                self.navigationBarViewModel.title.send(coinDetails.name)
                self.navigationBarViewModel.description.send("(\(coinDetails.symbol.uppercased()))")
                self.navigationBarViewModel.imageURL.send(coinDetails.imageURL)
                
                var currentPriceText = preciseRound(coinDetails.currentPrice,
                                                    precision: .thousandths).description
                currentPriceText.insert(contentsOf: "usd".currencySymbol, at: currentPriceText.startIndex)
                self.currentPriceText.send(currentPriceText)
                self.currentPrice.send(coinDetails.currentPrice)
                
                ActivityIndicator.hide()
            }, failure: { [weak self] error in
                self?.errorHandlerClosure?(error)
                ActivityIndicator.hide()
            })
        }
        
        func fetchCoinChartData(for timeInterval: TimeInterval) {
            ActivityIndicator.show()
            coinsInteractor.getCoinMarketChart(id: coinId, currency: "usd",
                                               startTimeInterval: timeInterval.offsetFromCurrentTime,
                                               endTimeInterval: .intervalSince1970,
                                               success: { [weak self] chartData in
                guard let self = self else { return }
                self.chartViewModel.dataSubject.send(
                    chartData.prices.map { CGFloat($0) }
                )
                
                let chartDataFirstPrice = chartData.prices.first ?? .zero
                let isPriceChangePositive = self.currentPrice.value > chartDataFirstPrice
                var priceChangeText = preciseRound(
                    self.currentPrice.value - chartDataFirstPrice,
                    precision: .thousandths
                ).description
                priceChangeText.insert(contentsOf: isPriceChangePositive ? "+" : .empty,
                                       at: priceChangeText.startIndex)
                
                let priceChangePercentage: Double
                if self.currentPrice.value > chartDataFirstPrice {
                    priceChangePercentage = preciseRound(
                        (self.currentPrice.value / chartDataFirstPrice - 1) * 100,
                        precision: .hundredths
                    )
                } else {
                    priceChangePercentage = preciseRound(
                        (chartDataFirstPrice / self.currentPrice.value - 1) * 100,
                        precision: .hundredths
                    )
                }
                
                priceChangeText.append(" (\(priceChangePercentage) %)")
                
                self.priceChangeText.send(priceChangeText)
                self.isPriceChangePositive.send(isPriceChangePositive)
                
                ActivityIndicator.hide()
            }, failure: { [weak self] error in
                self?.errorHandlerClosure?(error)
                ActivityIndicator.hide()
            })
        }
    }
}

extension CoinDetailsViewController.ViewModel {
    func didTapCloseButton() {
        closeTransition?()
    }
    
    func didTapOpenBottomSheetButton() {
        openBottomSheetTransition?()
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
