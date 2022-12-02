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
    private let coreDataSource: CoreDataSource
    private var cachedCoins = [Coin]()
    
    public init(coreDataSource: CoreDataSource) {
        self.coreDataSource = coreDataSource
    }
    
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
    
    // MARK: - Methods
    public func createOrUpdate(coins: [Coin],
                               success: @escaping Closure.Void,
                               failure: @escaping Closure.GeneralError) {
        coreDataSource.update(
            { [weak self] context in
                try coins.forEach { coin in
                    try self?.createOrUpdateCoin(with: coin, context: context)
                }
            }, success: success, failure: failure
        )
    }
    
    public func createOrUpdateCoin(with coin: Coin, context: NSManagedObjectContext) throws {
        let fetchRequest = CoinEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "id == %@", coin.id)
        
        if let storedCoinEntity = try context.fetch(fetchRequest).first {
            storedCoinEntity.update(with: coin)
        } else {
            let coinEntity = CoinEntity(context: context)
            coinEntity.update(with: coin)
        }
    }
    
    public func getPortfolioCoins(success: @escaping Closure.CoinsArray,
                                  failure: @escaping Closure.GeneralError) {
        coreDataSource.read(
            { context in
                let fetchRequest = CoinEntity.fetchRequest()
                fetchRequest.predicate = .init(format: "amount != 0.0")
                let entities = try context.fetch(fetchRequest)
                
                return entities.map { Coin(coinEntity: $0) }
            }, success: success, failure: failure
        )
    }
    
    public func getFavouritesCoins(success: @escaping Closure.CoinsArray,
                                   failure: @escaping Closure.GeneralError) {
        coreDataSource.read(
            { context in
                let fetchRequest = CoinEntity.fetchRequest()
                fetchRequest.predicate = .init(format: "isFavourite = %d", true)
                let entities = try context.fetch(fetchRequest)
                
                return entities.map { Coin(coinEntity: $0) }
            }, success: success, failure: failure
        )
    }
    
    public func getStoredCoin(withId id: String,
                              success: @escaping Closure.OptionalCoin,
                              failure: @escaping Closure.GeneralError) {
        coreDataSource.read(
            { context in
                let fetchRequest = CoinEntity.fetchRequest()
                fetchRequest.predicate = .init(format: "id == %@", id)
                if let entity = try context.fetch(fetchRequest).first {
                    return Coin(coinEntity: entity)
                } else {
                    return nil
                }
            }, success: success, failure: failure
        )
    }
}
