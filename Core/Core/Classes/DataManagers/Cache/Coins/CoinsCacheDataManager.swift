//
//  CoinsCacheDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 2.11.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import CoreData
import Combine

public final class CoinsCacheDataManager: CoinsCacheDataManagerProtocol {
    private let coreDataSource: CoreDataSource
    
    public init(coreDataSource: CoreDataSource) {
        self.coreDataSource = coreDataSource
    }
    
    public func createOrUpdate(coins: [Coin]) -> AnyPublisher<Void, Error> {
            return Future { promise in
                self.coreDataSource.update(
                    { context in
                        try coins.forEach { coin in
                            try self.createOrUpdateCoin(with: coin, context: context)
                        }
                    },
                    success: { promise(.success($0)) },
                    failure: { promise(.failure($0)) }
                )
            }
            .share()
            .eraseToAnyPublisher()
        }
    
    func createOrUpdateCoin(with coin: Coin, context: NSManagedObjectContext) throws {
//        let fetchRequest = CoinEntity.fetchRequest()
        let coinEntity = CoinEntity(context: context)
        coinEntity.update(with: coin)
    }
    
    public func getStoredCoins() -> AnyPublisher<[Coin], Error> {
        Future { promise in
            self.coreDataSource.update(
                { context in
                    let fetchRequest = CoinEntity.fetchRequest()
                    let entities = try context.fetch(fetchRequest)
                    
                    return entities.map { Coin(coinEntity: $0) }
                },
                success: { promise(.success($0)) },
                failure: { promise(.failure($0)) }
            )
        }
        .share()
        .eraseToAnyPublisher()
    }
}
