//
//  ServicesAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.02.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Core

enum ServicesAssembly: Assembly {
    static func coins(resolver: DependencyResolver) -> CoinsServiceProtocol {
        CoinsService(
            coinsAPIDataManager: APIAssembly.coinsAPIDataManager(),
            coinsCacheDataManager: resolver.resolve(CoinsCacheDataManager.self)
        )
    }
    
    static func composeUser(resolver: DependencyResolver) -> ComposeUserServiceProtocol {
        ComposeUserService(
            composeUserCacheDataManager: resolver.resolve(ComposeUserCacheDataManager.self)
        )
    }
}
