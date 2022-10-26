//
//  HomeCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class TrendingCoordinator: NavigationCoordinator {
    override init(parent: Coordinator?) {
        super.init(parent: parent)
        
        showCoinsListScreen()
    }
}

extension TrendingCoordinator: CoinDetailsInfoScreenPresentable {
    func showCoinsListScreen() {
        let (viewController, viewModel) = TrendingAssembly.makeCoinsListScreen(resolver: self)
        viewModel.showCoinDetailInfoTransition = { [weak self] in
            self?.showCoinDetailInfoScreen(coinId: $0)
        }
        
        pushViewController(viewController, animated: false)
    }
}
