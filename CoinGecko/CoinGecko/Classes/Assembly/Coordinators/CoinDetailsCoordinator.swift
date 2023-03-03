//
//  CoinDetailsCoordinator.swift
//  CoinGecko
//
//  Created by Max Sashcheka on 30.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import UIKit
import Utils

final class CoinDetailsCoordinator: NavigationCoordinator {
    // TODO: Remove this closure
    var presentationControllerDidDismissed: Closure.Void?
    
    struct Transitions {
        let close: Transition
    }
    
    private let transitions: Transitions
    
    init(parent: Coordinator?,
         transitions: Transitions,
         coinId: String,
         isAddToPortfolioEnabled: Bool = true) {
        self.transitions = transitions
        
        super.init(parent: parent)
        
        showCoinDetailInfoScreen(coinId: coinId, isAddToPortfolioEnabled: isAddToPortfolioEnabled)
    }
}

// MARK: - CoinDetailsCoordinator+SreensAssembly
extension CoinDetailsCoordinator {
    func showCoinDetailInfoScreen(coinId: String, isAddToPortfolioEnabled: Bool) {
        let transitions = CoinDetailsViewController.ViewModel.Transitions(
            close: { [weak self] in self?.transitions.close() },
            bottomSheet: { [weak self] in self?.showAddCoinBottomSheet(coinId: coinId) },
            browser: showInAppWebBrowserTransition
        )
        
        let screen = CommonAssembly.coinDetailsScreen(
            transitions: transitions,
            resolver: self,
            coinId: coinId,
            isAddToPortfolioEnabled: isAddToPortfolioEnabled
        )

        pushViewController(screen, animated: false)
    }
}

// MARK: - CoinDetailsCoordinator+UIViewControllerTransitioningDelegate
extension CoinDetailsCoordinator: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented,
                               presentingViewController: presenting,
                               dismissAction: { [weak self] in self?.dismissModalController() })
    }
}

// MARK: - CoinDetailsCoordinator+CoinBottomSheetPresentable
extension CoinDetailsCoordinator: CoinBottomSheetPresentable { }

// MARK: - CoinDetailsCoordinator+InAppWebBrowserPresentable
extension CoinDetailsCoordinator: InAppWebBrowserPresentable { }
