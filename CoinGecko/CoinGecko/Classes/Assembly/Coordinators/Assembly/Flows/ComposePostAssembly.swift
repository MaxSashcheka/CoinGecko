//
//  ComposePostAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

enum ComposePostAssembly { }

// MARK: - Screens

extension ComposePostAssembly {
    static func composePostInfoScreen(
        transitions: ComposePostInfoViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> ComposePostInfoViewController {
        let viewController = ComposePostInfoViewController()
        let viewModel = ComposePostInfoViewController.ViewModel(
            transitions: transitions, services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func composePostPhotoScreen(
        transitions: ComposePostPhotoViewModel.Transitions,
        resolver: DependencyResolver
    ) -> ComposePostPhotoViewController {
        let viewController = ComposePostPhotoViewController()
        let viewModel = ComposePostPhotoViewModel(
            transitions: transitions, services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
}

// MARK: - DI

extension ComposePostInfoViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(composePost: ServicesAssembly.composePost(resolver: resolver))
    }
}

extension ComposePostPhotoViewModel.ComposePostServices: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(composePost: ServicesAssembly.composePost(resolver: resolver),
             firebaseProvider: ProvidersAssembly.firebase())
    }
}
