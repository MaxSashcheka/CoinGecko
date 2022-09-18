//
//  Coin.swift
//  Core
//
//  Created by Maksim Sashcheka on 16.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public struct Coin {
    public let id: String
    public let symbol: String
    public let name: String
    public let imageURL: URL
    public let currentPrice: Double
    public let marketCap: Int
    public let marketCapRank: Int
    public let totalVolume: Int
    public let previousDayHighestPrice: Double
    public let previousDayLowestPrice: Double
    public let previousDayPriceChange: Double
    public let previousDayPriceChangePercentage: Double
}

extension Coin: Decodable {
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
        case previousDayPriceChange = "price_change_24h"
        case previousDayPriceChangePercentage = "price_change_percentage_24h"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageURL = try container.decode(URL.self, forKey: .imageURL)
        self.currentPrice = try container.decode(Double.self, forKey: .currentPrice)
        self.marketCap = try container.decode(Int.self, forKey: .marketCap)
        self.marketCapRank = try container.decode(Int.self, forKey: .marketCapRank)
        self.totalVolume = try container.decode(Int.self, forKey: .totalVolume)
        self.previousDayHighestPrice = try container.decode(Double.self, forKey: .previousDayHighestPrice)
        self.previousDayLowestPrice = try container.decode(Double.self, forKey: .previousDayLowestPrice)
        self.previousDayPriceChange = try container.decode(Double.self, forKey: .previousDayPriceChange)
        self.previousDayPriceChangePercentage = try container.decode(Double.self, forKey: .previousDayPriceChangePercentage)
    }
}
