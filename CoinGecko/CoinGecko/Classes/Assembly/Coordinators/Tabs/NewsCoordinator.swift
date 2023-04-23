//
//  NewsCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core
import Utils

final class NewsCoordinator: NavigationCoordinator {
    override init(parent: Coordinator?) {
        super.init(parent: parent)
        
        showNewsListScreen()
    }
}

extension NewsCoordinator {
    func showNewsListScreen() {
        let transitions = NewsListViewController.ViewModel.Transitions(
            postDetails: { [weak self] in self?.showPostDetailsCoordinator(postId: $0) },
            composePost: { [weak self] in self?.showComposePostCoordinator(completion: $0) }
        )
        let screen = NewsAssembly.newsListScreen(
            transitions: transitions,
            resolver: self
        )
        
        pushViewController(screen, animated: false)
    }
    
    func showPostDetailsCoordinator(postId: UUID) {
        let transitions = PostDetailsCoordinator.Transitions(
            close: { [weak self] in self?.dismissModalCoordinator() }
        )
        let coordinator = PostDetailsCoordinator(
            parent: self,
            transitions: transitions,
            postId: postId
        )
        presentModal(coordinator: coordinator, presentationStyle: .fullScreen)
    }
    
    func showComposePostCoordinator(completion: @escaping Closure.Void) {
        let transitions = ComposePostCoordinator.Transitions(
            close: { [weak self] in self?.dismissModalCoordinator() }
        )
        let coordinator = ComposePostCoordinator(
            parent: self,
            transitions: transitions,
            completion: completion
        )
        presentModal(coordinator: coordinator, presentationStyle: .fullScreen)
    }
}
