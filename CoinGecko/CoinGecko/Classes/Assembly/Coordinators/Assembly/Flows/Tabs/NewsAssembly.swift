//
//  NewsAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 22.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core

enum NewsAssembly { }

// MARK: - Screens

extension NewsAssembly {
    static func newsListScreen(
        transitions: NewsListViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> NewsListViewController {
        let viewController = NewsListViewController()
        let viewModel = NewsListViewController.ViewModel(
            transitions: transitions, services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func postDetailsScreen(
        id: UUID,
        transitions: PostDetailsViewController.ViewModel.Transitions,
        resolver: DependencyResolver
    ) -> PostDetailsViewController {
        let viewController = PostDetailsViewController()
        let viewModel = PostDetailsViewController.ViewModel(
            id: id,
            transitions: transitions,
            services: .inject(from: resolver)
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
}

// MARK: - DI

extension NewsListViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(posts: ServicesAssembly.posts(resolver: resolver))
    }
}

extension PostDetailsViewController.ViewModel.Services: DependencyInjectable {
    static func inject(from resolver: DependencyResolver) -> Self {
        Self(posts: ServicesAssembly.posts(resolver: resolver))
    }
}
