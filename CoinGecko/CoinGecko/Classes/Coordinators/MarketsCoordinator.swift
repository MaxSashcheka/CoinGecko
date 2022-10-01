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

private extension MarketsCoordinator {
    func showMarketsScreen() {
        let (viewController, viewModel) = MarketsAssembly.makeMarketsScreen(resolver: self)
        
        pushViewController(viewController, animated: false)
    }
}
