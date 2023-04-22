//
//  NewsListViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension NewsListViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        init(transitions: Transitions,
             services: Services) {
            self.services = services
            self.transitions = transitions
            
            super.init()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.transitions.postDetails(UUID())
            }
        }
    }
}

// MARK: - NewsListViewModel+NestedTypes
extension NewsListViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        var postDetails: Closure.UUID
    }
    
    final class Services {
        init() {
            
        }
    }
}
