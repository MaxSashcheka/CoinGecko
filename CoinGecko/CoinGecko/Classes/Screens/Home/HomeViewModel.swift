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
    final class ViewModel: ErrorHandableViewModel, PriceConvertable {
        private typealias Texts = L10n.Home.NetworthCard.Status
        
        private let coinsInteractor: CoinsInteractorProtocol
        
        init(coinsInteractor: CoinsInteractorProtocol) {
            self.coinsInteractor = coinsInteractor
            
            super.init()
        }
        
        var openSettingsTransition: Closure.Void?
        var openProfileTransition: Closure.Void?
        var openBottomSheetTransition: Closure.String?
        
        let navigationBarViewModel = HomeNavigationBarView.ViewModel()
        let networthCardViewModel = NetworhCardView.ViewModel()
        
        let coinsViewModels = CurrentValueSubject<[NetworthCoinCell.ViewModel], Never>([])
        let deleteCoinSubject = PassthroughSubject<String, Never>()
    }
}

// MARK: - HomeViewController.ViewModel+Fetch
extension HomeViewController.ViewModel {
    func fetchPortfolioCoins() {
        coinsInteractor.getPortfolioCoins(success: { [weak self] coins in
            self?.setupNethwordCardViewModel(with: coins)
            self?.setupCoinsViewModels(with: coins)
        }, failure: errorHandlerClosure)
    }
    
    func deleteCoin(withId id: String) {
        coinsInteractor.getStoredCoin(withId: id, success: { [weak self] coin in
            guard let self = self else { return }
            guard var coin = coin else {
                self.errorHandlerClosure(.coreDataError)
                return
            }
            coin.amount = .zero
            self.coinsInteractor.createOrUpdate(coin: coin, success: { [weak self] in
                self?.fetchPortfolioCoins()
            }, failure: self.errorHandlerClosure)
        }, failure: errorHandlerClosure)
    }
}

// MARK: - HomeViewController.ViewModel+SetupViewModels
private extension HomeViewController.ViewModel {
    func setupNethwordCardViewModel(with coins: [Coin]) {
        var totalNetworth: Double = .zero
        var dayProfit: Double = .zero
        coins.forEach {
            totalNetworth += $0.priceDetails.currentPrice * ($0.amount ?? .zero)
            dayProfit += $0.priceDetails.change24h * ($0.amount ?? .zero)
        }

        networthCardViewModel.networthValue.send(
            roundedValueString(totalNetworth)
        )
        networthCardViewModel.dayProfitValue.send(
            roundedValueString(abs(dayProfit))
        )
        networthCardViewModel.dayProfitTitle.send(dayProfit > .zero ? Texts.up : Texts.down)
    }
    
    func setupCoinsViewModels(with coins: [Coin]) {
        coinsViewModels.send(
            coins.compactMap { coin in
                guard let amount = coin.amount else { return nil }
                
                let isPriceChangePositive = coin.priceDetails.changePercentage24h > .zero
                let priceChangeString = roundedValuePriceChangeString(
                    coin.priceDetails.changePercentage24h,
                    isChangePositive: isPriceChangePositive
                )
                
                return NetworthCoinCell.ViewModel(
                    id: coin.id,
                    imageURL: coin.imageURL,
                    name: coin.name,
                    symbol: coin.symbol.uppercased(),
                    currentPrice: roundedValueString(coin.priceDetails.currentPrice),
                    priceChangePercentage: priceChangeString ,
                    isPriceChangePositive: isPriceChangePositive,
                    portfolioCount: amount,
                    portfolioPrice: roundedValueString(amount * coin.priceDetails.currentPrice)
                )
            }
        )
    }
}

// MARK: - HomeViewController.ViewModel+TableMethods
extension HomeViewController.ViewModel {
    var coinsCount: Int { coinsViewModels.value.count }
    
    func cellViewModel(for indexPath: IndexPath) -> NetworthCoinCell.ViewModel {
        coinsViewModels.value[indexPath.row]
    }
    
    func didSelectCoin(at indexPath: IndexPath) {
        openBottomSheetTransition?(coinsViewModels.value[indexPath.row].id)
    }
}

// MARK: - HomeViewController.ViewModel+TapActions
extension HomeViewController.ViewModel {
    func didTapSettingsButton() {
        openSettingsTransition?()
    }
    
    func didTapProfileButton() {
        openProfileTransition?()
    }
    
    func presentationControllerDidDismissed() {
        fetchPortfolioCoins()
    }
}
