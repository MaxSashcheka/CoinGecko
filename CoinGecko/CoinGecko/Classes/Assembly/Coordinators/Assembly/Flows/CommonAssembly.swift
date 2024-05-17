//
//  CommonAssembly.swift
//  CoinGecko
//
//  Created by Max Sashcheka on 30.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core

enum CommonAssembly: Assembly { }

// MARK: - Screens

extension CommonAssembly {
    static func coinDetailsScreen(
        transitions: CoinDetailsViewController.ViewModel.Transitions,
        resolver: DependencyResolver,
        coinId: String
    ) -> CoinDetailsViewController {
        let viewController = CoinDetailsViewController()
        let viewModel = CoinDetailsViewController.ViewModel(
            transitions: transitions,
            services: .inject(from: resolver),
            coinId: coinId
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func inAppWebBroserScreen(
        transitions: InAppWebBrowserViewController.ViewModel.Transitions,
        url: URL
    ) -> InAppWebBrowserViewController {
        let viewController = InAppWebBrowserViewController(url: url)
        let viewModel = InAppWebBrowserViewController.ViewModel(
            transitions: transitions
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func imagePickerScreen(
        transitions: ImagePickerViewController.ViewModel.Transitions
    ) -> ImagePickerViewController {
        let viewController = ImagePickerViewController()
        let viewModel = ImagePickerViewController.ViewModel(transitions: transitions)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func addCoinScreen(
        coinId: String,
        transitions: AddCoinViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> AddCoinViewController {
        let viewController = AddCoinViewController()
        let viewModel = AddCoinViewController.ViewModel(
            coinId: coinId,
            transitions: transitions,
            services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
}

// MARK: - DI

extension CoinDetailsViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(users: ServicesAssembly.users(resolver: resolver),
             coins: ServicesAssembly.coins(resolver: resolver),
             externalLinkBuilder: resolver.resolve(ExternalLinkBuilder.self))
    }
}

extension AddCoinViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(wallets: ServicesAssembly.wallets(resolver: resolver))
    }
}
