//
//  ServicesAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.02.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core

enum ServicesAssembly: Assembly {
    static func users(resolver: DependencyResolver) -> UsersServiceProtocol {
        UsersService(
            appPropertiesDataManager: resolver.resolve(AppPropertiesDataManager.self),
            usersCacheDataManager: resolver.resolve(UsersCacheDataManager.self)
        )
    }
    
    static func auth(resolver: DependencyResolver) -> AuthServiceProtocol {
        AuthService(
            appPropertiesDataManager: resolver.resolve(AppPropertiesDataManager.self),
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
    
    static func wallets(resolver: DependencyResolver) -> WalletsServiceProtocol {
        WalletsService(
            walletsCacheDataManager: resolver.resolve(WalletsCacheDataManager.self),
            usersCacheDataManager: resolver.resolve(UsersCacheDataManager.self),
            walletsAPIDataManager: APIAssembly.wallets()
        )
    }
    
    static func composeUser(resolver: DependencyResolver) -> ComposeUserServiceProtocol {
        ComposeUserService(
            appPropertiesDataManager: resolver.resolve(AppPropertiesDataManager.self),
            composeUserCacheDataManager: resolver.resolve(ComposeUserCacheDataManager.self),
            usersCacheDataManager: resolver.resolve(UsersCacheDataManager.self),
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
