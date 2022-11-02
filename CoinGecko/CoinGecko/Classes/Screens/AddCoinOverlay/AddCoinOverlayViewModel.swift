//
//  AddCoinOverlayViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 31.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

extension AddCoinOverlayViewController {
    final class ViewModel {
        var closeTransition: Closure.Void?
        
        func didTriggerCloseAction() {
            closeTransition?()
        }
    }
}
