//
//  CoinEntity+Extensions.swift
//  Core
//
//  Created by Maksim Sashcheka on 5.11.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

extension CoinEntity {
    func update(with coin: Coin) {
        self.change24h = coin.priceDetails.change24h
        self.changePercentage24h = coin.priceDetails.changePercentage24h
        self.currentPrice = coin.priceDetails.currentPrice
        self.id = coin.id
        self.imageURL = coin.imageURL
        self.marketCap = Int64(coin.priceDetails.marketCap)
        self.marketCapRank = Int64(coin.priceDetails.marketCapRank)
        self.name = coin.name
        self.previousDayLowestPrice = coin.priceDetails.previousDayLowestPrice
        self.previousDayHighestPrice = coin.priceDetails.previousDayHighestPrice
        self.symbol = coin.symbol
        self.totalVolume = coin.priceDetails.totalVolume
        if let coinAmount = coin.amount {
            self.amount = coinAmount
        }
        if let isFavourite = coin.isFavourite {
            self.isFavourite = isFavourite
        }
    }
        
}
