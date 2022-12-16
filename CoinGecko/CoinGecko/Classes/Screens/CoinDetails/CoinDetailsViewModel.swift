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
    final class ViewModel: ErrorHandableViewModel {
        enum RangeButtonConfig: CaseIterable {
            case hour, day, week, month, halfYear, year, all
        }
        
        private let coinsInteractor: CoinsInteractorProtocol
        private let coinId: String
        let isAddToPortfolioEnabled: Bool
        
        var closeTransition: Closure.Void?
        var openBottomSheetTransition: Closure.Void?
        
        let navigationBarViewModel = CoinDetailsNavigationBarView.ViewModel()
        let chartViewModel = ChartView.ViewModel()
        let buttonsCollectionViewModel = ButtonsCollectionView.ViewModel()
        
        let currentPrice = CurrentValueSubject<Double, Never>(.zero)
        let currentPriceText = CurrentValueSubject<String, Never>(.empty)
        let priceChangeText = CurrentValueSubject<String, Never>(.empty)
        let isPriceChangePositive = CurrentValueSubject<Bool, Never>(false)
        let hideAddButtonSubject = PassthroughSubject<Void, Never>()
        
        init(coinId: String,
             coinsInteractor: CoinsInteractorProtocol,
             isAddToPortfolioEnabled: Bool) {
            self.coinId = coinId
            self.coinsInteractor = coinsInteractor
            self.isAddToPortfolioEnabled = isAddToPortfolioEnabled
            
            super.init()
            
            buttonsCollectionViewModel.buttonsViewModels.send(
                RangeButtonConfig.allCases.map {
                    RangePickerButton.ViewModel(title: $0.title, offsetTimeInterval: $0.timeInterval)
                }
            )
            
            fetchStoredCoin()
            fetchCoinDetails()
            fetchCoinChartData(for: .hour)
        }
    }
}

// MARK: - CoinDetailsViewController.ViewModel+Fetch
extension CoinDetailsViewController.ViewModel {
    func fetchStoredCoin() {
        coinsInteractor.getStoredCoin(withId: coinId, success: { [weak navigationBarViewModel] coin in
            guard let coin = coin else { return }
            navigationBarViewModel?.isFavourite.send(coin.isFavourite ?? false)
        }, failure: { [weak self] error in
            self?.errorHandlerClosure(error)
        })
    }
    
    func fetchCoinDetails() {
        coinsInteractor.getCoinDetails(id: coinId,
                                       success: { [weak self] coinDetails in
            guard let self = self else { return }
            self.navigationBarViewModel.title.send(coinDetails.name)
            self.navigationBarViewModel.description.send(coinDetails.symbol.uppercased())
            self.navigationBarViewModel.imageURL.send(coinDetails.imageURL)
            
            self.currentPriceText.send(StringConverter.roundedValueString(coinDetails.currentPrice))
            self.currentPrice.send(coinDetails.currentPrice)
            
            ActivityIndicator.hide()
        }, failure: { [weak self] error in
            self?.errorHandlerClosure(error)
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
            self?.errorHandlerClosure(error)
            ActivityIndicator.hide()
        })
    }
}

// MARK: - CoinDetailsViewController.ViewModel+TapActions
extension CoinDetailsViewController.ViewModel {
    func didTapCloseButton() {
        closeTransition?()
    }
    
    func didTapAddToFavouriteButton() {
        coinsInteractor.getStoredCoin(withId: coinId, success: { [weak self] coin in
            guard let self = self else { return }
            guard var coin = coin else {
                self.errorHandlerClosure(.coreDataError)
                return
            }
            let newFavouriteState = !(coin.isFavourite ?? false)
            coin.isFavourite = newFavouriteState
            self.coinsInteractor.createOrUpdate(coin: coin, success: { [weak self] in
                self?.navigationBarViewModel.isFavourite.send(newFavouriteState)
            }, failure: self.errorHandlerClosure)
        }, failure: errorHandlerClosure)
    }
    
    func didTapOpenBottomSheetButton() {
        openBottomSheetTransition?()
    }
}

// MARK: - RangeButtonConfig+ComputedProperties
extension CoinDetailsViewController.ViewModel.RangeButtonConfig {
    typealias Texts = L10n.RangeButton.Title
    var title: String {
        switch self {
        case .hour: return Texts.hour
        case .day: return Texts.day
        case .week: return Texts.week
        case .month: return Texts.month
        case .halfYear: return Texts.halfYear
        case .year: return Texts.year
        case .all: return Texts.all
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
