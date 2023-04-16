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
    func showAddCoinBottomSheet(coinId: String)
    var presentationControllerDidDismissed: Closure.Void? { get }
}

extension CoinBottomSheetPresentable where Self: Coordinator & UIViewControllerTransitioningDelegate {
    var showAddCoinBottomSheetTransition: Closure.String {
        { [weak self] in self?.showAddCoinBottomSheet(coinId: $0) }
    }
    
    func showAddCoinBottomSheet(coinId: String) {
        let transitions = AddCoinOverlayViewController.ViewModel.Transitions(
            close: { [weak self] in
                self?.presentationControllerDidDismissed?()
                self?.dismissModalController()
            }
        )
        let screen = CommonAssembly.addCoinBottomSheet(
            transitions: transitions,
            resolver: self,
            coinId: coinId
        )
        
        screen.transitioningDelegate = self
        
        presentModal(controller: screen, presentationStyle: .custom, animated: true)
    }
}
