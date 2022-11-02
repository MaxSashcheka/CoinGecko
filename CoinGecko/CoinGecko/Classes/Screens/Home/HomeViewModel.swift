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
        var openSettingsTransition: Closure.Void?
        var openProfileTransition: Closure.Void?
        
        let navigationBarViewModel = HomeNavigationBarView.ViewModel()
        let networthCardViewModel = NetworhCardView.ViewModel()
        
        let coinsViewModels = CurrentValueSubject<[NetworthCoinCell.ViewModel], Never>([])
        var coinsCount: Int { coinsViewModels.value.count }
        
        func fetchPortfolioCoins() {
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
