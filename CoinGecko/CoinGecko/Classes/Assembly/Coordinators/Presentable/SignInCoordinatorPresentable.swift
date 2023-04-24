//
//  SignInCoordinatorPresentable.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

protocol SignInCoordinatorPresentable {
    func showSignInCoordinator(completion: @escaping Closure.Void)
}

extension ComposeUserCoordinatorPresentable where Self: NavigationCoordinator {
    func showSignInCoordinator(completion: @escaping Closure.Void) {
        let transitions = SignInCoordinator.Transitions(
            close: { [weak self] in self?.dismissModalCoordinator() }
        )
        let coordinator = SignInCoordinator(
            parent: self,
            transitions: transitions,
            completion: completion
        )
        presentModal(coordinator: coordinator, presentationStyle: .fullScreen)
    }
    
    var showSignInCoordinatorTransition: (@escaping Closure.Void) -> Void {
        { [weak self] in self?.showSignInCoordinator(completion: $0) }
    }
}
