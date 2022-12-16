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
        let (viewController, viewModel) = HomeAssembly.makeHomeScreen(resolver: self)
        viewModel.openSettingsTransition = { [weak self] in
            self?.showSettingsScreen()
        }
        viewModel.openProfileTransition = { [weak self] in
            self?.showProfileScreen()
        }
        viewModel.openBottomSheetTransition = showAddCoinBottomSheetTransition
        
        // TODO: - Try to fix this logic for detecting presentation controller dismissed in home view model
        homeViewModel = viewModel
        
        pushViewController(viewController, animated: false)
    }
    
    func showSettingsScreen() {
        let (viewController, _) = HomeAssembly.makeSettingsScreen(resolver: self)
        
        pushViewController(viewController, animated: true)
    }
    
    func showProfileScreen() {
        let (viewController, _) = HomeAssembly.makeProfileScreen(resolver: self)
        
        pushViewController(viewController, animated: true)
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
