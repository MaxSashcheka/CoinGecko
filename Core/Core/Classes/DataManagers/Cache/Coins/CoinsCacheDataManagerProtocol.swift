//
//  CoinsCacheDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 2.11.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public protocol CoinsCacheDataManagerProtocol {
    var cachedCoins: CacheContainer<String, Coin> { get }
}
