//
//  Coin.swift
//  Core
//
//  Created by Maksim Sashcheka on 16.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias OptionalCoin = (Core.Coin?) -> Swift.Void
    typealias Coin = (Core.Coin) -> Swift.Void
    typealias CoinsArray = ([Core.Coin]) -> Swift.Void
}

public struct Coin {
    public let id: String
    public let symbol: String
    public let name: String
    public let imageURL: URL?
    public let priceDetails: PriceDetails
    public var amount: Double?
    public var isFavourite: Bool?
}

public struct PriceDetails {
    public let currentPrice: Double
    public let marketCap: Int
    public let marketCapRank: Int
    public let totalVolume: Double
    public let previousDayHighestPrice: Double
    public let previousDayLowestPrice: Double
    public let change24h: Double
    public let changePercentage24h: Double
}

// MARK: Coin+CoinResponse
public extension Coin {
    init(coinResponse: CoinResponse) {
        self.id = coinResponse.id
        self.symbol = coinResponse.symbol
        self.name = coinResponse.name
        self.imageURL = coinResponse.imageURL
        
        self.priceDetails = PriceDetails(
            currentPrice: coinResponse.currentPrice ?? .zero,
            marketCap: coinResponse.marketCap ?? .zero,
            marketCapRank: coinResponse.marketCapRank ?? .zero,
            totalVolume: coinResponse.totalVolume ?? .zero,
            previousDayHighestPrice: coinResponse.previousDayHighestPrice ?? .zero,
            previousDayLowestPrice: coinResponse.previousDayLowestPrice ?? .zero,
            change24h: coinResponse.priceChange24h ?? .zero,
            changePercentage24h: coinResponse.priceChangePercentage24h ?? .zero
        )
    }
}
