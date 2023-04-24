//
//  ProvidersAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.02.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core

// MARK: - SessionsAssembly
enum SessionsAssembly: Assembly {
    static func usersCacheDataManager(resolver: DependencyResolver) -> UsersCacheDataManager {
        UsersCacheDataManager()
    }
    
    static func coinsCacheDataManager(resolver: DependencyResolver) -> CoinsCacheDataManager {
        CoinsCacheDataManager()
    }
    
    static func postsCacheDataManager(resolver: DependencyResolver) -> PostsCacheDataManager {
        PostsCacheDataManager()
    }
    
    static func composeUserCacheDataManager(resolver: DependencyResolver) -> ComposeUserCacheDataManager {
        ComposeUserCacheDataManager()
    }
    
    static func composePostCacheDataManager(resolver: DependencyResolver) -> ComposePostCacheDataManager {
        ComposePostCacheDataManager()
    }
}

// MARK: - API Assembly

enum APIAssembly: Assembly {
    static func auth() -> AuthAPIDataManager {
        AuthAPIDataManager()
    }
    
    static func coins() -> CoinsAPIDataManager {
        CoinsAPIDataManager()
    }
    
    static func users() -> UsersAPIDataManager {
        UsersAPIDataManager()
    }
    
    static func posts() -> PostsAPIDataManager {
        PostsAPIDataManager()
    }
}

// MARK: - Providers Assembly

enum ProvidersAssembly {
    static func firebase() -> FirebaseProvider {
        FirebaseProvider()
    }
}

extension UsersCacheDataManager: DependencyResolvable { }
extension CoinsCacheDataManager: DependencyResolvable { }
extension PostsCacheDataManager: DependencyResolvable { }
extension ComposeUserCacheDataManager: DependencyResolvable { }
extension ComposePostCacheDataManager: DependencyResolvable { }
