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
            accountWallets: { [weak self] in self?.showAccountWalletsScreen() },
            usersList: { [weak self] in self?.showUsersListScreen() }
        )
        let screen = HomeAssembly.homeScreen(
            transitions: transitions,
            resolver: self
        )
        
        pushViewController(screen, animated: false)
    }
    
    func showAccountWalletsScreen() {
        let transitions = AccountWalletsViewController.ViewModel.Transitions(
            composeWallet: { [weak self] in self?.showComposeWalletCoordinator(completion: $0) },
            walletDetails: { [weak self] id, completion in
                self?.showWalletDetailsScreen(walletId: id, completion: { [weak self] in
                    self?.popViewController(animated: true)
                    completion()
                })
            }
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
    
    func showWalletDetailsScreen(walletId: UUID, completion: @escaping Closure.Void) {
        let transitions = WalletDetailsViewController.ViewModel.Transitions(
            completion: completion
        )
        
        let screen = HomeAssembly.walletDetailsScreen(
            walletId: walletId,
            transitions: transitions,
            resolver: self
        )
        
        pushViewController(screen)
    }
    
    func showUsersListScreen() {
        let transitions = UsersListViewController.ViewModel.Transitions(
            userDetails: { [weak self] in self?.showExternalProfileScreen(userId: $0) }
        )
        
        let screen = HomeAssembly.usersListScreen(
            transitions: transitions,
            resolver: self
        )
        
        pushViewController(screen)
    }
    
    func showExternalProfileScreen(userId: UUID) {
        let transitions = ExternalProfileViewController.ViewModel.Transitions()
        
        let screen = HomeAssembly.externalProfileScreen(
            userId: userId,
            transitions: transitions,
            resolver: self
        )
        
        pushViewController(screen)
    }
}

// MARK: - HomeCoordinator+ComposeUserCoordinatorPresentable
extension HomeCoordinator: ComposeUserCoordinatorPresentable { }

// MARK: - HomeCoordinator+SignInCoordinatorPresentable
extension HomeCoordinator: SignInCoordinatorPresentable { }

// MARK: - HomeCoordinator+ExternalLinkPresentable
extension HomeCoordinator: InAppWebBrowserPresentable { }
