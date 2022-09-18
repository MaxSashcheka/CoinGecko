//
//  CoinDetails.swift
//  Core
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public struct CoinDetails {
    public let id: String
    public let symbol: String
    public let name: String
    public let description: CoinDescription
    public let image: CoinImage
    public let marketData: MarketData
}

extension CoinDetails: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case description
        case image
        case marketData = "market_data"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(CoinDescription.self, forKey: .description)
        self.image = try container.decode(CoinImage.self, forKey: .image)
        self.marketData = try container.decode(MarketData.self, forKey: .marketData)
    }
}



public struct CoinDescription: Decodable {
    public let descriptionText: String
    
    private enum CodingKeys: String, CodingKey {
        case descriptionText = "en"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.descriptionText = try container.decode(String.self, forKey: .descriptionText)
    }
}

public struct CoinImage: Decodable {
    public let thumbURL: URL
    public let smallURL: URL
    public let largeURL: URL
    
    private enum CodingKeys: String, CodingKey {
        case thumbURL = "thumb"
        case smallURL = "small"
        case largeURL = "large"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.thumbURL = try container.decode(URL.self, forKey: .thumbURL)
        self.smallURL = try container.decode(URL.self, forKey: .smallURL)
        self.largeURL = try container.decode(URL.self, forKey: .largeURL)
    }
}

public struct MarketData: Decodable {
    public let priceChange24h: Double
    public let priceChangePercentage24h: Double
    public let priceChangePercentage7d: Double
    public let priceChangePercentage14d: Double

    private enum CodingKeys: String, CodingKey {
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case priceChangePercentage7d = "price_change_percentage_7d"
        case priceChangePercentage14d = "price_change_percentage_14d"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        self.priceChange24h = try container.decode(Double.self, forKey: .priceChange24h)
        self.priceChangePercentage24h = try container.decode(Double.self, forKey: .priceChangePercentage24h)
        self.priceChangePercentage7d = try container.decode(Double.self, forKey: .priceChangePercentage7d)
        self.priceChangePercentage14d = try container.decode(Double.self, forKey: .priceChangePercentage14d)
    }
}
