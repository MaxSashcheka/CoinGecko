//
//  PostDetailsCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core
import Utils

final class PostDetailsCoordinator: NavigationCoordinator {
    struct Transitions {
        let close: Transition
    }
    
    private let transitions: Transitions
    
    init(parent: Coordinator?,
         transitions: Transitions,
         postId: UUID) {
        self.transitions = transitions
        
        super.init(parent: parent)
        
        showPostDetailsScreen(id: postId)
    }
}

extension PostDetailsCoordinator {
    func showPostDetailsScreen(id: UUID) {
        let transitions = PostDetailsViewController.ViewModel.Transitions(
            close: { [weak self] in self?.transitions.close() }
        )
        
        let screen = NewsAssembly.postDetailsScreen(
            id: id,
            transitions: transitions,
            resolver: self
        )
        
        pushViewController(screen, animated: false)
    }
}
