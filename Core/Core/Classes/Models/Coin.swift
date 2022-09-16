//
//  Coin.swift
//  Core
//
//  Created by Maksim Sashcheka on 16.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

struct Coin {
    let id: String
    let symbol: String
    let name: String
    let image: URL
    let current_price: Float
    let market_cap: Int
    let market_cap_rank: Int
    let fully_diluted_valuation: Int
    let total_volume: Int
    let high_24h: Float
    let low_24h: Float
    let price_change_24h: Float
    let price_change_percentage_24h: Float
    let market_cap_change_24h: Float
    let market_cap_change_percentage_24h: Float
}
