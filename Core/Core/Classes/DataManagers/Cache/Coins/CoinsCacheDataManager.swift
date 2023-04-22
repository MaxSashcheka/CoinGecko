//
//  CoinsCacheDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 2.11.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import CoreData
import Utils

public final class CoinsCacheDataManager: CoinsCacheDataManagerProtocol {
    public var cachedCoins = CacheContainer<String, Coin>()
    
    public init() { }
}
