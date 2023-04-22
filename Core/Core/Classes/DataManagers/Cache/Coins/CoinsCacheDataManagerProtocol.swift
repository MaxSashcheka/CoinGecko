//
//  CoinsCacheDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 2.11.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import CoreData
import Utils

public protocol CoinsCacheDataManagerProtocol {
    var cachedCoins: [Coin] { get }
    
    func addToCache(coins: [Coin])
    
    func cachedCoin(withId id: String) -> Coin?
}
