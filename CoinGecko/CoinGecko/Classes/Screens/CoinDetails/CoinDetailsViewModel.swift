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
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable, PriceConvertable {
        private let services: Services
        let transitions: Transitions

        private let coinId: String
        
        let chartViewModel = ChartView.ViewModel()
        let buttonsCollectionViewModel = ButtonsCollectionView.ViewModel()
        
        let coinTitle = CurrentValueSubject<String, Never>(.empty)
        let coinImageURL = CurrentValueSubject<URL?, Never>(nil)
        let currentPrice = CurrentValueSubject<Double, Never>(.zero)
        let currentPriceText = CurrentValueSubject<String, Never>(.empty)
        let priceChangeText = CurrentValueSubject<String, Never>(.empty)
        let isPriceChangePositive = CurrentValueSubject<Bool, Never>(false)
        let isAddToPortfolioButtonHidden = CurrentValueSubject<Bool, Never>(false)
        let hideAddButtonSubject = PassthroughSubject<Void, Never>()
        
        init(transitions: Transitions,
             services: Services,
             coinId: String) {
            self.services = services
            self.transitions = transitions
            self.coinId = coinId
            
            super.init()
            
            buttonsCollectionViewModel.buttonsViewModels.send(
                RangeButtonConfig.allCases.map {
                    RangePickerButton.ViewModel(title: $0.title, offsetTimeInterval: $0.timeInterval)
                }
            )
            
            fetchCurrentUserData()
            fetchCoinDetails()
            fetchCoinChartData(for: .hour)
        }
    }
}

// MARK: - CoinDetailsViewModel+NestedTypes
extension CoinDetailsViewController.ViewModel {
    enum RangeButtonConfig: CaseIterable {
        case hour, day, week, month, halfYear, year, all
    }
    
    struct Transitions: ScreenTransitions {
        let close: Transition
        let browser: Closure.URL
        let addToWallet: Transition
    }
    
    final class Services {
        let users: UsersServiceProtocol
        let coins: CoinsServiceProtocol
        let externalLinkBuilder: ExternalLinkBuilder
        
        init(users: UsersServiceProtocol,
             coins: CoinsServiceProtocol,
             externalLinkBuilder: ExternalLinkBuilder) {
            self.users = users
            self.coins = coins
            self.externalLinkBuilder = externalLinkBuilder
        }
    }
}

// MARK: - CoinDetailsViewModel+Fetch
extension CoinDetailsViewController.ViewModel {
    func fetchCurrentUserData() {
        isAddToPortfolioButtonHidden.send(services.users.currentUser.isNil)
    }
    
    func fetchCoinDetails() {
        services.coins.getCoinDetails(
            id: coinId,
            success: { [weak self] coinDetails in
                guard let self = self else { return }
                self.coinTitle.send(coinDetails.name)
                self.coinImageURL.send(coinDetails.imageURL)
                
                self.currentPriceText.send(self.roundedValueString(coinDetails.currentPrice))
                self.currentPrice.send(coinDetails.currentPrice)
                
                ActivityIndicator.hide()
            }, failure: { [weak self] error in
                self?.errorHandlerClosure(error)
                ActivityIndicator.hide()
            }
        )
    }
    
    func fetchCoinChartData(for timeInterval: TimeInterval) {
        ActivityIndicator.show()
        services.coins.getCoinMarketChart(id: coinId, currency: "usd",
                                           startTimeInterval: timeInterval.offsetFromCurrentTime,
                                           endTimeInterval: .intervalSince1970,
                                           success: { [weak self] chartData in
            guard let self = self else { return }
            self.chartViewModel.dataSubject.send(chartData.pricesWithData)
            
            let chartDataFirstPrice = chartData.pricesWithData.first?.price ?? .zero
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

// MARK: - CoinDetailsViewModel+TapActions
extension CoinDetailsViewController.ViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
    
    func didTapAddToWalletButton() {
        transitions.addToWallet()
    }
    
    func didTapBrowserButton() {
        services.coins.getStoredCoin(
            id: coinId,
            success: { [weak self] in
                guard let url = self?.services.externalLinkBuilder.buildGoogleSearchURL(query: $0.name) else { return }
                self?.transitions.browser(url)
            },
            failure: { [weak self] in self?.errorHandlerClosure($0)}
        )
    }
}

// MARK: - RangeButtonConfig+ComputedProperties
extension CoinDetailsViewController.ViewModel.RangeButtonConfig {
    private typealias Texts = L10n.RangeButton.Title
    
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
