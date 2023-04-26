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
    override init(parent: Coordinator?) {
        super.init(parent: parent)
        
        showHomeScreen()
    }
}

// MARK: - HomeCoordinator+SreensAssembly
extension HomeCoordinator {
    func showHomeScreen() {
        let transitions = HomeViewController.ViewModel.Transitions(
            signIn: showSignInCoordinatorTransition,
            signUp: showComposeUserCoordinatorTransition,
            personalWebPage: showInAppWebBrowserTransition,
            accountWallets: { [weak self] in self?.showAccountWalletsScreen() }
        )
        let screen = HomeAssembly.homeScreen(
            transitions: transitions,
            resolver: self
        )
        
        pushViewController(screen, animated: false)
    }
    
    func showAccountWalletsScreen() {
        let transitions = AccountWalletsViewController.ViewModel.Transitions(
            composeWallet: { [weak self] in self?.showComposeWalletCoordinator(completion: $0) }
        )
        
        let screen = HomeAssembly.accountWalletsScreen(
            transitions: transitions,
            resolver: self
        )
        
        pushViewController(screen)
    }
    
    func showComposeWalletCoordinator(completion: @escaping Closure.Void) {
        let transitions = ComposeWalletCoordinator.Transitions(
            close: { [weak self] in self?.dismissModalCoordinator() }
        )
        let coordinator = ComposeWalletCoordinator(
            parent: self,
            transitions: transitions,
            completion: completion
        )
        presentModal(coordinator: coordinator, presentationStyle: .fullScreen)
    }
}

// MARK: - HomeCoordinator+ComposeUserCoordinatorPresentable
extension HomeCoordinator: ComposeUserCoordinatorPresentable { }

// MARK: - HomeCoordinator+SignInCoordinatorPresentable
extension HomeCoordinator: SignInCoordinatorPresentable { }

// MARK: - HomeCoordinator+ExternalLinkPresentable
extension HomeCoordinator: InAppWebBrowserPresentable { }
