//
//  CoinsCacheDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 2.11.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import CoreData
import Combine

public protocol CoinsCacheDataManagerProtocol {
    func createOrUpdate(coins: [Coin]) -> AnyPublisher<Void, Error>
    func getStoredCoins() -> AnyPublisher<[Coin], Error>
}
