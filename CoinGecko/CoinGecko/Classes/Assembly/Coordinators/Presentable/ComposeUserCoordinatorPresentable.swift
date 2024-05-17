//
//  ComposeUserCoordinatorPresentable.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

protocol ComposeUserCoordinatorPresentable {
    func showComposeUserCoordinator(completion: @escaping Closure.Void)
}

extension ComposeUserCoordinatorPresentable where Self: NavigationCoordinator {
    func showComposeUserCoordinator(completion: @escaping Closure.Void) {
        let transitions = ComposeUserCoordinator.Transitions(
            close: { [weak self] in self?.dismissModalCoordinator() }
        )
        let coordinator = ComposeUserCoordinator(
            parent: self,
            transitions: transitions,
            completion: completion
        )
        presentModal(coordinator: coordinator, presentationStyle: .fullScreen)
    }
    
    var showComposeUserCoordinatorTransition: (@escaping Closure.Void) -> Void {
        { [weak self] in self?.showComposeUserCoordinator(completion: $0) }
    }
}
