//
//  NewsListViewModel.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import Core
import Utils

extension NewsListViewController {
    final class ViewModel: ErrorHandableViewModel, ScreenTransitionable {
        private let services: Services
        let transitions: Transitions
        
        let postsViewModels = CurrentValueSubject<[PostTableCell.ViewModel], Never>([])
        let isAddPostButtonHidden = CurrentValueSubject<Bool, Never>(false)
        
        init(transitions: Transitions,
             services: Services) {
            self.services = services
            self.transitions = transitions
            
            super.init()
            
            fetchCurrentUserData()
        }
    }
}

// MARK: - NewsListViewModel+NestedTypes
extension NewsListViewController.ViewModel {
    struct Transitions: ScreenTransitions {
        var postDetails: Closure.UUID
        var composePost: (@escaping Closure.Void) -> Void
    }
    
    final class Services {
        let users: UsersServiceProtocol
        let posts: PostsServiceProtocol
        
        init(users: UsersServiceProtocol,
             posts: PostsServiceProtocol) {
            self.users = users
            self.posts = posts
        }
    }
}

// MARK: - NewsListViewModel+TableViewDataProviders
extension NewsListViewController.ViewModel {
    var numberOfItems: Int { postsViewModels.value.count }
    
    func cellViewModel(for indexPath: IndexPath) -> PostTableCell.ViewModel {
        postsViewModels.value[indexPath.row]
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        transitions.postDetails(cellViewModel(for: indexPath).id)
    }
}

// MARK: - NewsListViewModel+FetchData
extension NewsListViewController.ViewModel {
    func fetchCurrentUserData() {
        guard let currentUser = services.users.currentUser else {
            isAddPostButtonHidden.send(true)
            return
        }
        isAddPostButtonHidden.send(currentUser.role == .user)
    }
    
    func fetchPosts(fromCache: Bool = false) {
        ActivityIndicator.show()
        services.posts.getPosts(
            fromCache: fromCache,
            success: { [weak self] posts in
                ActivityIndicator.hide()
                self?.postsViewModels.send(
                    posts.map {
                        PostTableCell.ViewModel(
                            id: $0.id,
                            imageURL: $0.imageURL,
                            title: $0.title
                        )
                    }
                )
            }, failure: { [weak self] in
                ActivityIndicator.hide()
                self?.errorHandlerClosure?($0)
            }
        )
    }
}

// MARK: - NewsListViewModel+TapActions
extension NewsListViewController.ViewModel {
    func didTapComposePostButton() {
        transitions.composePost { [weak self] in
            self?.fetchPosts(fromCache: true)
        }
    }
}
