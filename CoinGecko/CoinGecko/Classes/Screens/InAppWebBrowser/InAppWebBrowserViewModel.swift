//
//  RootCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 07.12.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

extension InAppWebBrowserViewController {
    final class ViewModel: ScreenTransitionable {
        let transitions: Transitions
        
        init(transitions: Transitions) {
            self.transitions = transitions
        }
        
        func didSafariViewControllerFinished() {
            transitions.close()
        }
    }
}

// MARK: - InAppWebBrowserViewModel+NestedTypes
extension InAppWebBrowserViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        let close: Transition
    }
}
