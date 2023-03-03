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
    var presentationControllerDidDismissed: Closure.Void?
    var homeViewModel: HomeViewController.ViewModel!
    
    override init(parent: Coordinator?) {
        super.init(parent: parent)
        
        showHomeScreen()
        
        presentationControllerDidDismissed = { [weak homeViewModel] in
            homeViewModel?.presentationControllerDidDismissed()
        }
    }
}

// MARK: - HomeCoordinator+SreensAssembly
extension HomeCoordinator {
    func showHomeScreen() {
        let transitions = HomeViewController.ViewModel.Transitions(
            settings: { [weak self] in self?.showSettingsScreen() },
            profile: { [weak self] in self?.showProfileScreen() },
            bottomSheet: showAddCoinBottomSheetTransition
        )
        let screen = HomeAssembly.homeScreen(
            transitions: transitions,
            resolver: self
        )
        
        // TODO: - Try to fix this logic for detecting presentation controller dismissed in home view model
//        homeViewModel = viewModel
        
        pushViewController(screen, animated: false)
    }
    
    func showSettingsScreen() {
        let screen = HomeAssembly.settingsScreen(
            transitions: .init(),
            resolver: self
        )
        
        pushViewController(screen, animated: true)
    }
    
    func showProfileScreen() {
        let screen = HomeAssembly.profileScreen(
            transitions: .init(),
            resolver: self
        )
        
        pushViewController(screen, animated: true)
    }
}

// MARK: - HomeCoordinator+UIViewControllerTransitioningDelegate
extension HomeCoordinator: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        let dismissAction: Closure.Void = { [weak self] in
            self?.presentationControllerDidDismissed?()
            self?.dismissModalController()
        }
        return PresentationController(presentedViewController: presented,
                                      presentingViewController: presenting,
                                      dismissAction: dismissAction)
    }
}

// MARK: - HomeCoordinator+CoinBottomSheetPresentable
extension HomeCoordinator: CoinBottomSheetPresentable { }
