//
//  CoinDetailsViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import RxCocoa
import RxSwift
import Utils

extension CoinDetailsViewController {
    final class ViewModel {
        enum RangeButtonConfig: CaseIterable {
            case hour, day, week, month, halfYear, year, all
        }
        
        private let coinsInteractor: CoinsInteractorProtocol
        private let coin: Coin
        
        var closeTransition: Closure.Void?
        var errorHandlerClosure: NetworkRouterErrorClosure?
        
        let navigationBarViewModel = CoinDetailsNavigationBarView.ViewModel()
        let chartViewModel = ChartView.ViewModel()
        let buttonsCollectionViewModel = ButtonsCollectionView.ViewModel()
        
        let currentPrice = BehaviorRelay<Double>(value: .zero)
        let priceChangeText = BehaviorRelay<String>(value: .empty)
        
        init(coin: Coin, coinsInteractor: CoinsInteractorProtocol) {
            self.coin = coin
            self.coinsInteractor = coinsInteractor
            
            navigationBarViewModel.title.accept(coin.name)
            navigationBarViewModel.description.accept("(\(coin.symbol.uppercased()))")
            navigationBarViewModel.imageURL.accept(coin.imageURL)
                        
            buttonsCollectionViewModel.buttonsViewModels.accept(
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
                self?.chartViewModel.dataRelay.accept(
                    chartData.prices.map { CGFloat($0) }
                )
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
