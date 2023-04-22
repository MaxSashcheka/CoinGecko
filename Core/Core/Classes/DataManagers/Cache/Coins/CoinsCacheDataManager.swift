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
    public var cachedCoins = [Coin]()
    
    public init() { }
    
    // MARK: - Cached coins
    public func addToCache(coins: [Coin]) {
        for coin in coins {
            if let index = cachedCoins.firstIndex(where: { $0.id == coin.id }) {
                cachedCoins[index] = coin
            } else {
                cachedCoins.append(coin)
            }
        }
    }
    
    public func cachedCoin(withId id: String) -> Coin? {
        guard let cachedCoin = cachedCoins.first(where: { $0.id == id }) else {
            return nil
        }
        return cachedCoin
    }
}
