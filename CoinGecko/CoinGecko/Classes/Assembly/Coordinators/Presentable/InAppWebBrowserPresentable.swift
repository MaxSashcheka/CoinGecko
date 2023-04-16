//
//  InAppWebBrowserPresentable.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 7.12.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

protocol InAppWebBrowserPresentable {
    func showInAppWebBrowser(url: URL)
}

extension InAppWebBrowserPresentable where Self: NavigationCoordinator {
    func showInAppWebBrowser(url: URL) {
        let transitions = InAppWebBrowserViewController.ViewModel.Transitions(
            close: { [weak self] in self?.dismissModalController() }
        )
        let screen = CommonAssembly.inAppWebBroserScreen(
            transitions: transitions,
            url: url
        )
        
        presentModal(controller: screen)
    }
    
    var showInAppWebBrowserTransition: Closure.URL {
        { [weak self] in self?.showInAppWebBrowser(url: $0) }
    }
}
