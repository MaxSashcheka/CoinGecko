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
    typealias ProfileViewModel = HomeViewController.ViewModel
    static func makeProfileScreen(resolver: Resolver) -> (HomeViewController, ProfileViewModel) {
        let viewController = HomeViewController()
        let viewModel = ProfileViewModel()
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
}
