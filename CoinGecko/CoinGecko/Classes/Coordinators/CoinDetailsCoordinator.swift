//
//  CoinDetailsCoordinator.swift
//  CoinGecko
//
//  Created by Max Sashcheka on 30.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils
import UIKit

final class CoinDetailsCoordinator: NavigationCoordinator {
    var closeClosure: Closure.Void?
     
    init(parent: Coordinator?, coinId: String, closeClosure: @escaping Closure.Void) {
        self.closeClosure = closeClosure
        
        super.init(parent: parent)
        
        showCoinDetailInfoScreen(coinId: coinId)
    }
}

extension CoinDetailsCoordinator {
    func showCoinDetailInfoScreen(coinId: String) {
        let (viewController, viewModel) = CommonAssembly.makeCoinDetailsScreen(resolver: self, coinId: coinId)
        viewModel.closeTransition = { [weak self] in
            self?.closeClosure?()
        }
        viewModel.openBottomSheetTransition = { [weak self] in
            self?.showAddCoinBottomSheet()
        }
   
        pushViewController(viewController, animated: false)
    }
    
    func showAddCoinBottomSheet() {
        let (viewController, viewModel) = CommonAssembly.makeAddCoinBottomSheet()
        viewModel.closeTransition = { [weak self] in
            self?.dismissModalController()
        }
        
        viewController.transitioningDelegate = self
        
        presentModal(controller: viewController, presentationStyle: .custom, animated: true)
    }
}

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
