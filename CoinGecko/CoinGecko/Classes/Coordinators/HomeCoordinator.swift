//
//  HomeCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class HomeCoordinator: NavigationCoordinator {
    override init(parent: Coordinator?) {
        super.init(parent: parent)
        
        showCoinsListScreen()
    }
}

private extension HomeCoordinator {
    func showCoinsListScreen() {
        let (viewController, viewModel) = HomeAssembly.makeCoinsListScreen(resolver: self)
        viewModel.showCoinDetailInfoTransition = { [weak self] in
            self?.showCoinDetailInfoScreen(coin: $0)
        }
        
        pushViewController(viewController, animated: false)
    }
    
    // TODO: - Move this method to protocol with extension to provide showing this screen from different places
    func showCoinDetailInfoScreen(coin: Coin) {
        let (viewController, viewModel) = HomeAssembly.makeCoinDetailsScreen(resolver: self, coin: coin)
        viewModel.closeTransition = { [weak self] in
            self?.dismissModalController()
        }
        
        presentModal(controller: viewController, presentationStyle: .overFullScreen)
    }
}
