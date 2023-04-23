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
    static func coinsAPIDataManager() -> CoinsAPIDataManager {
        CoinsAPIDataManager()
    }
    
    static func usersAPIDataManager() -> UsersAPIDataManager {
        UsersAPIDataManager()
    }
    
    static func postsAPIDataManager() -> PostsAPIDataManager {
        PostsAPIDataManager()
    }
}

// MARK: - DataManagers Assembly

//enum DataManagersAssembly: Assembly {
//    static func firebaseDataManager() -> FirebaseDataManager {
//        FirebaseDataManager()
//    }
//}

enum ProvidersAssembly {
    static func firebase() -> FirebaseProvider {
        FirebaseProvider()
    }
}

extension CoinsCacheDataManager: DependencyResolvable { }
extension PostsCacheDataManager: DependencyResolvable { }
extension ComposeUserCacheDataManager: DependencyResolvable { }
extension ComposePostCacheDataManager: DependencyResolvable { }
