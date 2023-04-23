//
//  ServicesAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.02.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core

// TODO: - Remove manually pointing cache data manager types
enum ServicesAssembly: Assembly {
    static func coins(resolver: DependencyResolver) -> CoinsServiceProtocol {
        CoinsService(
            coinsAPIDataManager: APIAssembly.coinsAPIDataManager(),
            coinsCacheDataManager: resolver.resolve(CoinsCacheDataManager.self)
        )
    }
    
    static func posts(resolver: DependencyResolver) -> PostsServiceProtocol {
        PostsService(
            postsCacheDataManager: resolver.resolve(PostsCacheDataManager.self),
            postsAPIDataManager: APIAssembly.postsAPIDataManager()
        )
    }
    
    static func composeUser(resolver: DependencyResolver) -> ComposeUserServiceProtocol {
        ComposeUserService(
            composeUserCacheDataManager: resolver.resolve(ComposeUserCacheDataManager.self),
            usersAPIDataManager: APIAssembly.usersAPIDataManager()
        )
    }
    
    static func composePost(resolver: DependencyResolver) -> ComposePostServiceProtocol {
        ComposePostService(
            composePostCacheDataManager: resolver.resolve(ComposePostCacheDataManager.self),
            postsCacheDataManager: resolver.resolve(PostsCacheDataManager.self),
            postsAPIDataManager: APIAssembly.postsAPIDataManager()
        )
    }
}
