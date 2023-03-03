//
//  ProfileViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

extension ProfileViewController {
    final class ViewModel {
        private let services: Services
        let transitions: Transitions
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services
        }
    }
}

// MARK: - ProfileViewModel+NestedTypes
extension ProfileViewController.ViewModel {
    struct Transitions: ScreenTransitions {

    }
    
    final class Services {
        
    }
}
