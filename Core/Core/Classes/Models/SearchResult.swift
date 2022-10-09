//
//  SearchResult.swift
//  Core
//
//  Created by Maksim Sashcheka on 9.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias SearchResult = (Core.SearchResult) -> (Swift.Void)
}

public struct SearchResult {
    public let coins: [SearchCoin]
    public let exchanges: [SearchExchange]
    public let categories: [SearchCategory]
    public let nfts: [SearchNFT]
    
    init(searchResponse: SearchResponse) {
        self.coins = searchResponse.coins.map {
            .init(searchCoinResponse: $0)
        }
        self.exchanges = searchResponse.exchanges.map {
            .init(searchExchangeResponse: $0)
        }
        self.categories = searchResponse.categories.map {
            .init(searchCategoryResponse: $0)
        }
        self.nfts = searchResponse.nfts.map {
            .init(searchNFTResponse: $0)
        }
    }
}

public struct SearchCoin {
    public let id: String
    public let name: String
    public let symbol: String
    public let marketCapRank: Int?
    public let thumbURL: URL
    public let largeURL: URL
    
    init(searchCoinResponse: SearchCoinResponse) {
        self.id = searchCoinResponse.id
        self.name = searchCoinResponse.name
        self.symbol = searchCoinResponse.symbol
        self.marketCapRank = searchCoinResponse.marketCapRank
        self.thumbURL = searchCoinResponse.thumb
        self.largeURL = searchCoinResponse.large
    }
}

public struct SearchExchange {
    public let id: String
    public let name: String
    public let thumbURL: URL
    public let largeURL: URL
    
    init(searchExchangeResponse: SearchExchangeResponse) {
        self.id = searchExchangeResponse.id
        self.name = searchExchangeResponse.name
        self.thumbURL = searchExchangeResponse.thumb
        self.largeURL = searchExchangeResponse.large
    }
}

public struct SearchCategory {
    public let id: Int
    public let name: String
    
    init(searchCategoryResponse: SearchCategoryResponse) {
        self.id = searchCategoryResponse.id
        self.name = searchCategoryResponse.name
    }
}

public struct SearchNFT {
    public let id: String
    public let name: String
    public let symbol: String
    public let thumbURL: URL
    
    init(searchNFTResponse: SearchNFTResponse) {
        self.id = searchNFTResponse.id
        self.name = searchNFTResponse.name
        self.symbol = searchNFTResponse.symbol
        self.thumbURL = searchNFTResponse.thumb
    }
}
