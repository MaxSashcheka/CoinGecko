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
        CoinsCacheDataManager(
            coreDataSource: resolver.resolve(CoreDataSource.self)
        )
    }
}

// MARK: - API Assembly

enum APIAssembly: Assembly {
    static func coinsAPIDataManager() -> CoinsAPIDataManager {
        CoinsAPIDataManager()
    }
}

extension CoinsCacheDataManager: DependencyResolvable { }
