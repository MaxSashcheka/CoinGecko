//
//  SettingsViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

extension SettingsViewController {
    final class ViewModel: ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        init(transitions: Transitions, services: Services) {
            self.transitions = transitions
            self.services = services
        }
    }
}

// MARK: - SettingsViewModel+NestedTypes
extension SettingsViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        
    }
    
    final class Services {
        
    }
}
