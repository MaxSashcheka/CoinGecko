//
//  PostDetailsViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension PostDetailsViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        private let postId: UUID
        
        init(id: UUID,
             transitions: Transitions,
             services: Services) {
            self.services = services
            self.transitions = transitions
            self.postId = id
            
            super.init()
        }
    }
}

// MARK: - PostDetailsViewModel+NestedTypes
extension PostDetailsViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        var close: Transition
    }
    
    final class Services {
        init() {
            
        }
    }
}

// MARK: - PostDetailsViewModel+TapActions
extension PostDetailsViewController.ViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
}
