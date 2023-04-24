//
//  SignInPlaceholderViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine

extension HomeViewController.SignInPlaceholderView {
    final class ViewModel {
        enum Mode {
            case signIn
            case signUp
        }
        
        let tapSubject = PassthroughSubject<Mode, Never>()
    }
}
