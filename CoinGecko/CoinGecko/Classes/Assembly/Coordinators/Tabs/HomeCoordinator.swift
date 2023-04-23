//
//  HomeCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import UIKit
import Utils

final class HomeCoordinator: NavigationCoordinator {
    var homeViewModel: HomeViewController.ViewModel!
    
    override init(parent: Coordinator?) {
        super.init(parent: parent)
        
        showHomeScreen()
    }
}

// MARK: - HomeCoordinator+SreensAssembly
extension HomeCoordinator {
    func showHomeScreen() {
        let transitions = HomeViewController.ViewModel.Transitions()
        let screen = HomeAssembly.homeScreen(
            transitions: transitions,
            resolver: self
        )
        
        pushViewController(screen, animated: false)
    }
}
