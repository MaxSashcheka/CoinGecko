//
//  CacheDataManagerAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class CacheDataManagerAssembly: Assembly {
    static func makeCoinsCacheDataManager(resolver: Resolver) -> CoinsCacheDataManager {
        CoinsCacheDataManager(
            coreDataSource: resolver.resolve(CoreDataSource.self)
        )
    }
}

extension CoinsCacheDataManager: Resolvable { }
