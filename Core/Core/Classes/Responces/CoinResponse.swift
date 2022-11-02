//
//  CoinResponse.swift
//  Core
//
//  Created by Maksim Sashcheka on 29.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias CoinsArrayReponse = ([Core.CoinResponse]) -> Swift.Void
}

public struct CoinsMarketResponse: Decodable {
    let coins: [CoinResponse]
}

public struct CoinResponse {
    public let id: String
    public let symbol: String
    public let name: String
    public let imageURL: URL
    public let currentPrice: Double?
    public let marketCap: Int?
    public let marketCapRank: Int?
    public let totalVolume: Double?
    public let previousDayHighestPrice: Double?
    public let previousDayLowestPrice: Double?
    public let priceChange24h: Double
    public let priceChangePercentage24h: Double
}

extension CoinResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case imageURL = "image"
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case totalVolume = "total_volume"
        case previousDayHighestPrice = "high_24h"
        case previousDayLowestPrice = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}
