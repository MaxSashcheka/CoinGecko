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
    func createOrUpdate(coins: [Coin],
                        success: @escaping Closure.Void,
                        failure: @escaping Closure.GeneralError)
    
    func createOrUpdateCoin(with coin: Coin,
                            context: NSManagedObjectContext) throws
    
    func getPortfolioCoins(success: @escaping Closure.CoinsArray,
                           failure: @escaping Closure.GeneralError)
    
    func getFavouritesCoins(success: @escaping Closure.CoinsArray,
                            failure: @escaping Closure.GeneralError)
    
    func getStoredCoin(withId id: String,
                       success: @escaping Closure.OptionalCoin,
                       failure: @escaping Closure.GeneralError)
    
    var cachedCoins: [Coin] { get }
    
    func addToCache(coins: [Coin])
    
    func cachedCoin(withId id: String) -> Coin?
}
