//
//  ComposeWalletAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

enum ComposeWalletAssembly { }

// MARK: - Screens

extension ComposeWalletAssembly {
    static func composeWalletScreen(
        transitions: ComposeWalletViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> ComposeWalletViewController {
        let viewController = ComposeWalletViewController()
        let viewModel = ComposeWalletViewController.ViewModel(
            transitions: transitions, services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func colorPickerScreen(
        transitions: ColorPickerViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> ColorPickerViewController {
        let viewController = ColorPickerViewController()
        let viewModel = ColorPickerViewController.ViewModel(transitions: transitions)
        viewController.viewModel = viewModel
        
        return viewController
    }
}

// MARK: - DI

extension ComposeWalletViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(wallets: ServicesAssembly.wallets(resolver: resolver))
    }
}
