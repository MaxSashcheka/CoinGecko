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
    var presentationControllerDidDismissed: Closure.Void?
    var closeClosure: Closure.Void?
     
    init(parent: Coordinator?,
         coinId: String,
         isAddToPortfolioEnabled: Bool = true,
         closeClosure: @escaping Closure.Void) {
        self.closeClosure = closeClosure
        
        super.init(parent: parent)
        
        showCoinDetailInfoScreen(coinId: coinId, isAddToPortfolioEnabled: isAddToPortfolioEnabled)
    }
}

// MARK: - CoinDetailsCoordinator+SreensAssembly
extension CoinDetailsCoordinator {
    func showCoinDetailInfoScreen(coinId: String, isAddToPortfolioEnabled: Bool) {
        let (viewController, viewModel) = CommonAssembly.makeCoinDetailsScreen(
            resolver: self,
            coinId: coinId,
            isAddToPortfolioEnabled: isAddToPortfolioEnabled
        )
        viewModel.closeTransition = { [weak self] in
            self?.closeClosure?()
        }
        viewModel.openBottomSheetTransition = { [weak self] in
            self?.showAddCoinBottomSheet(coinId: coinId)
        }

        pushViewController(viewController, animated: false)
    }
}

// MARK: - CoinDetailsCoordinator+UIViewControllerTransitioningDelegate
extension CoinDetailsCoordinator: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        let dismissAction: Closure.Void = { [weak self] in self?.dismissModalController() }
        return PresentationController(presentedViewController: presented,
                                      presentingViewController: presenting,
                                      dismissAction: dismissAction)
    }
}

// MARK: - CoinDetailsCoordinator+CoinBottomSheetPresentable
extension CoinDetailsCoordinator: CoinBottomSheetPresentable { }
