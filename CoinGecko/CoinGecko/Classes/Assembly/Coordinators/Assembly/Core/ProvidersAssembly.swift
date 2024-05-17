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
    
    static func walletsCacheDataManager(resolver: DependencyResolver) -> WalletsCacheDataManager {
        WalletsCacheDataManager()
    }
    
    static func composeUserCacheDataManager(resolver: DependencyResolver) -> ComposeUserCacheDataManager {
        ComposeUserCacheDataManager()
    }
    
    static func composePostCacheDataManager(resolver: DependencyResolver) -> ComposePostCacheDataManager {
        ComposePostCacheDataManager()
    }
    
    static func appPropertiesDataManager(resolver: DependencyResolver) -> AppPropertiesDataManager {
        AppPropertiesDataManager(group: "group.coingecko.properties")
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
    
    static func wallets() -> WalletsAPIDataManager {
        WalletsAPIDataManager()
    }
}

// MARK: - Providers Assembly

enum ProvidersAssembly {
    static func firebase() -> FirebaseProvider {
        FirebaseProvider()
    }
}

extension AppPropertiesDataManager: DependencyResolvable { }
extension UsersCacheDataManager: DependencyResolvable { }
extension CoinsCacheDataManager: DependencyResolvable { }
extension PostsCacheDataManager: DependencyResolvable { }
extension WalletsCacheDataManager: DependencyResolvable { }
extension ComposeUserCacheDataManager: DependencyResolvable { }
extension ComposePostCacheDataManager: DependencyResolvable { }
