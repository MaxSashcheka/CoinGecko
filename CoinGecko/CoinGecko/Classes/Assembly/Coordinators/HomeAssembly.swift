//
//  HomeAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

final class HomeAssembly { }

// MARK: - Screens
extension HomeAssembly {
    typealias HomeViewModel = HomeViewController.ViewModel
    static func makeHomeScreen(resolver: Resolver) -> (HomeViewController, HomeViewModel) {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel(
            coinsInteractor: InteractorsAssembly.makeCoinsInteractor(resolver: resolver)
        )
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
    typealias SettingsViewModel = SettingsViewController.ViewModel
    static func makeSettingsScreen(resolver: Resolver) -> (SettingsViewController, SettingsViewModel) {
        let viewController = SettingsViewController()
        let viewModel = SettingsViewModel()
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
    typealias ProfileViewModel = ProfileViewController.ViewModel
    static func makeProfileScreen(resolver: Resolver) -> (ProfileViewController, ProfileViewModel) {
        let viewController = ProfileViewController()
        let viewModel = ProfileViewModel()
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
}
