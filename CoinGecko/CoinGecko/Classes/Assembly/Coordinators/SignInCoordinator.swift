//
//  SignInCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core
import Utils

final class SignInCoordinator: NavigationCoordinator {
    struct Transitions {
        let close: Transition
    }
    
    private let transitions: Transitions
    private let completionClosure: Closure.Void
    
    init(parent: Coordinator?,
         transitions: Transitions,
         completion: @escaping Closure.Void) {
        self.transitions = transitions
        self.completionClosure = completion
        
        super.init(parent: parent)
        
        showSignInScreen()
    }
}

extension SignInCoordinator {
    func showSignInScreen() {
        let transitions = SignInViewController.ViewModel.Transitions(
            close: { [weak self] in self?.transitions.close() },
            completion: { [weak self] in
                self?.completionClosure()
                self?.transitions.close()
            }
        )
        let screen = ComposeUserAssembly.signInScreen(
            transitions: transitions,
            resolver: self
        )
        pushViewController(screen, animated: false)
    }
}
