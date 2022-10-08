//
//  CoinDetailsInfoScreenPresentable.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 4.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

protocol CoinDetailsInfoScreenPresentable { }
extension CoinDetailsInfoScreenPresentable where Self: NavigationCoordinator {
    func showCoinDetailInfoScreen(coin: Coin) {
        // TODO: - move makeCoinDetailsScreen into general assembly
        let (viewController, viewModel) = HomeAssembly.makeCoinDetailsScreen(resolver: self, coin: coin)
        viewModel.closeTransition = { [weak self] in
            self?.dismissModalController()
        }
        
        presentModal(controller: viewController, presentationStyle: .overFullScreen)
    }
}