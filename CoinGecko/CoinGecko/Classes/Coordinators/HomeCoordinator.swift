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

extension HomeCoordinator: CoinDetailsInfoScreenPresentable {
    func showCoinsListScreen() {
        let (viewController, viewModel) = HomeAssembly.makeCoinsListScreen(resolver: self)
        viewModel.showCoinDetailInfoTransition = { [weak self] in
            self?.showCoinDetailInfoScreen(coinId: $0)
        }
        
        pushViewController(viewController, animated: false)
    }
}
