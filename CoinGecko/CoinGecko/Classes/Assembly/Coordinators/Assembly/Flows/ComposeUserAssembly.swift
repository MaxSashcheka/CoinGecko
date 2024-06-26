//
//  ComposeUserAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

enum ComposeUserAssembly { }

// MARK: - Screens

extension ComposeUserAssembly {
    static func composeUserInfoScreen(
        transitions: ComposeUserInfoViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> ComposeUserInfoViewController {
        let viewController = ComposeUserInfoViewController()
        let viewModel = ComposeUserInfoViewController.ViewModel(
            transitions: transitions, services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func composeUserPhotoScreen(
        transitions: ComposeUserPhotoViewModel.Transitions,
        resolver: DependencyResolver
    ) -> ComposeUserPhotoViewController {
        let viewController = ComposeUserPhotoViewController()
        let viewModel = ComposeUserPhotoViewModel(
            transitions: transitions, services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func signInScreen(
        transitions: SignInViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> SignInViewController {
        let viewController = SignInViewController()
        let viewModel = SignInViewController.ViewModel(
            transitions: transitions, services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
}

// MARK: - DI

extension ComposeUserInfoViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(composeUser: ServicesAssembly.composeUser(resolver: resolver))
    }
}

extension ComposeUserPhotoViewModel.ComposeUserServices: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(composeUser: ServicesAssembly.composeUser(resolver: resolver),
             firebaseProvider: ProvidersAssembly.firebase())
    }
}

extension SignInViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(auth: ServicesAssembly.auth(resolver: resolver))
    }
}
