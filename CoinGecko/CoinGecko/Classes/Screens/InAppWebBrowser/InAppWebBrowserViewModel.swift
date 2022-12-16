//
//  RootCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 07.12.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

extension InAppWebBrowserViewController {
    final class ViewModel {
        var closeTransition: Closure.Void?
        
        func didSafariViewControllerFinished() {
            closeTransition?()
        }
    }
}
