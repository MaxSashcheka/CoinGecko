//
//  CoinDetails.swift
//  Core
//
//  Created by Maksim Sashcheka on 9.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias CoinDetails = (Core.CoinDetails) -> Swift.Void
}

public struct CoinDetails {
    public let id: String
    public let name: String
    public let symbol: String
    public let imageURL: URL
    public let marketCapRank: Int
    public let currentPrice: Double
}

public extension CoinDetails {
    init(coinDetailsResponse: CoinDetailsResponse) {
        self.id = coinDetailsResponse.id
        self.name = coinDetailsResponse.name ?? .empty
        self.symbol = coinDetailsResponse.symbol ?? .empty
        self.imageURL = coinDetailsResponse.image.large
        self.marketCapRank = coinDetailsResponse.marketCapRank ?? .zero
        self.currentPrice = coinDetailsResponse.marketData.currentPrice.usd ?? .zero
    }
}
