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
        coinId: String,
        isAddToPortfolioEnabled: Bool
    ) -> CoinDetailsViewController {
        let viewController = CoinDetailsViewController()
        let viewModel = CoinDetailsViewController.ViewModel(
            transitions: transitions,
            services: .inject(from: resolver),
            coinId: coinId,
            isAddToPortfolioEnabled: isAddToPortfolioEnabled
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func addCoinBottomSheet(
        transitions: AddCoinOverlayViewController.ViewModel.Transitions,
        resolver: DependencyResolver,
        coinId: String
    ) -> AddCoinOverlayViewController {
        let viewController = AddCoinOverlayViewController()
        let viewModel = AddCoinOverlayViewController.ViewModel(
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
}

// MARK: - DI

extension CoinDetailsViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(coins: ServicesAssembly.coins(resolver: resolver),
             externalLinkBuilder: resolver.resolve(ExternalLinkBuilder.self))
    }
}

extension AddCoinOverlayViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(coins: ServicesAssembly.coins(resolver: resolver))
    }
}
