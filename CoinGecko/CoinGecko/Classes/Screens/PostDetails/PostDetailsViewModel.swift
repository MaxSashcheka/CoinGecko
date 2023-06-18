//
//  PostDetailsViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension PostDetailsViewController {
    final class ViewModel: ScreenTransitionable, HandlersAccessible {
        private let services: Services
        private let postId: UUID
        let transitions: Transitions
        
        let imageURL = CurrentValueSubject<URL?, Never>(nil)
        let titleText = CurrentValueSubject<String, Never>(.empty)
        let contentText = CurrentValueSubject<String, Never>(.empty)
        
        init(id: UUID,
             transitions: Transitions,
             services: Services) {
            self.services = services
            self.transitions = transitions
            self.postId = id
            
            fetchPost()
        }
    }
}

// MARK: - PostDetailsViewModel+NestedTypes
extension PostDetailsViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        var close: Transition
    }
    
    final class Services {
        let posts: PostsServiceProtocol
        
        init(posts: PostsServiceProtocol) {
            self.posts = posts
        }
    }
}

// MARK: - PostDetailsViewModel+FetchData
extension PostDetailsViewController.ViewModel {
    func fetchPost() {
        services.posts.getPost(
            id: postId,
            fromCache: true,
            success: { [weak self] post in
                self?.imageURL.send(post.imageURL)
                self?.titleText.send(post.title)
                self?.contentText.send(post.content)
            },
            failure: errorsHandler.handleClosure
        )
    }
}

// MARK: - PostDetailsViewModel+TapActions
extension PostDetailsViewController.ViewModel {
    func didTapCloseButton() {
        transitions.close()
    }
}
