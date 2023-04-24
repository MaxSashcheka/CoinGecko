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
    static func auth(resolver: DependencyResolver) -> AuthServiceProtocol {
        AuthService(
            usersCacheDataManager: resolver.resolve(UsersCacheDataManager.self),
            authAPIDataManager: APIAssembly.auth()
        )
    }
    
    static func coins(resolver: DependencyResolver) -> CoinsServiceProtocol {
        CoinsService(
            coinsAPIDataManager: APIAssembly.coins(),
            coinsCacheDataManager: resolver.resolve(CoinsCacheDataManager.self)
        )
    }
    
    static func posts(resolver: DependencyResolver) -> PostsServiceProtocol {
        PostsService(
            postsCacheDataManager: resolver.resolve(PostsCacheDataManager.self),
            postsAPIDataManager: APIAssembly.posts()
        )
    }
    
    static func composeUser(resolver: DependencyResolver) -> ComposeUserServiceProtocol {
        ComposeUserService(
            composeUserCacheDataManager: resolver.resolve(ComposeUserCacheDataManager.self),
            usersAPIDataManager: APIAssembly.users()
        )
    }
    
    static func composePost(resolver: DependencyResolver) -> ComposePostServiceProtocol {
        ComposePostService(
            composePostCacheDataManager: resolver.resolve(ComposePostCacheDataManager.self),
            postsCacheDataManager: resolver.resolve(PostsCacheDataManager.self),
            postsAPIDataManager: APIAssembly.posts()
        )
    }
}
