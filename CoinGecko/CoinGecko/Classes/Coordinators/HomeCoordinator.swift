//
//  HomeCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

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
        viewModel.showCoinDetailInfoTransition = { [weak self] id in
            self?.showCoinDetailInfoScreen(id: id)
        }
        
        pushViewController(viewController, animated: false)
    }
    
    // TODO: - Move this method to protocol with extension to provide showing this screen from different places
    func showCoinDetailInfoScreen(id: String) {
        let (viewController, viewModel) = HomeAssembly.makeCoinsListScreen(resolver: self, coinId: id)
        viewModel.closeTransition = { [weak self] in
            self?.dismissModalController()
        }
        
        presentModal(controller: viewController, presentationStyle: .overFullScreen)
    }
}

