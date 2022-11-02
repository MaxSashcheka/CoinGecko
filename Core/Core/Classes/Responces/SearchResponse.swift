//
//  SearchResponse.swift
//  Core
//
//  Created by Maksim Sashcheka on 9.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias SearchResponse = (Core.SearchResponse) -> (Swift.Void)
}

public struct SearchResponse: Decodable {
    public let coins: [SearchCoinResponse]
    public let exchanges: [SearchExchangeResponse]
    public let categories: [SearchCategoryResponse]
    public let nfts: [SearchNFTResponse]
}

public struct SearchCoinResponse: Decodable {
    public let id: String
    public let name: String
    public let symbol: String
    public let marketCapRank: Int?
    public let thumb: URL
    public let large: URL
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case marketCapRank = "market_cap_rank"
        case thumb
        case large
    }
}

public struct SearchExchangeResponse: Decodable {
    public let id: String
    public let name: String?
    public let thumb: URL
    public let large: URL
}

public struct SearchCategoryResponse: Decodable {
    public let id: Int
    public let name: String?
}

public struct SearchNFTResponse: Decodable {
    public let id: String
    public let name: String?
    public let symbol: String?
    public let thumb: URL
}



