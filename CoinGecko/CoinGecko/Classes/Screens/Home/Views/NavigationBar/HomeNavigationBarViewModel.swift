//
//  HomeNavigationBarViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Foundation

extension HomeViewController.HomeNavigationBarView {
    final class ViewModel {
        let name = CurrentValueSubject<String, Never>(.empty)
        let email = CurrentValueSubject<String, Never>(.empty)
        let profileButtonSubject = PassthroughSubject<Void, Never>()
        let settingsButtonSubject = PassthroughSubject<Void, Never>()

        init(name: String = .empty,
             email: String = .empty) {
            self.name.send(name)
            self.email.send(email)
        }
    }
}
