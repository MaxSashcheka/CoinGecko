//
//  MarketsCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class MarketsCoordinator: NavigationCoordinator {
    override init(parent: Coordinator?) {
        super.init(parent: parent)
        
        showMarketsScreen()
    }
}

extension MarketsCoordinator {
    func showMarketsScreen() {
        let (viewController, viewModel) = MarketsAssembly.makeMarketsScreen(resolver: self)
        viewModel.showCoinDetailInfoTransition = { [weak self] in
            self?.showCoinDetailsCoordinator(coinId: $0)
        }
        viewModel.showSearchTransition = { [weak self] in
            self?.showSearchScreen()
        }
        
        pushViewController(viewController, animated: false)
    }
    
    func showSearchScreen() {
        let (viewController, viewModel) = MarketsAssembly.makeSearchScreen(resolver: self)
        viewModel.showCoinDetailInfoTransition = { [weak self] in
            self?.showCoinDetailsCoordinator(coinId: $0)
        }
        
        pushViewController(viewController, animated: true)
    }
    
    func showCoinDetailsCoordinator(coinId: String) {
        let coordinator = CoinDetailsCoordinator(parent: self,
                                                 coinId: coinId,
                                                 closeClosure: { [weak self] in
                                                     self?.dismissModalCoordinator()
                                                 })
        presentModal(coordinator: coordinator, presentationStyle: .overFullScreen)
    }
}
