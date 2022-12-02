//
//  CoinBottomSheetPresentable.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 7.11.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit
import Utils

protocol CoinBottomSheetPresentable {
    var presentationControllerDidDismissed: Closure.Void? { get }
}

extension CoinBottomSheetPresentable where Self: Coordinator & UIViewControllerTransitioningDelegate {
    var showAddCoinBottomSheetTransition: Closure.String {
        { [weak self] in self?.showAddCoinBottomSheet(coinId: $0) }
    }
    
    func showAddCoinBottomSheet(coinId: String) {
        let (viewController, viewModel) = CommonAssembly.makeAddCoinBottomSheet(
            resolver: self,
            coinId: coinId
        )
        viewModel.closeTransition = { [weak self] in
            self?.presentationControllerDidDismissed?()
            self?.dismissModalController()
        }
        
        viewController.transitioningDelegate = self
        
        presentModal(controller: viewController, presentationStyle: .custom, animated: true)
    }
}
