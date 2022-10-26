//
//  HomeViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension HomeViewController {
    final class ViewModel {
        var openSettingsTransition: Closure.Void?
        
        func didTapSettingsButton() {
            openSettingsTransition?()
        }
    }
}
