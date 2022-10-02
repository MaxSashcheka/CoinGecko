//
//  ParametersProviders.swift
//  Core
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public extension ParametersProvider {
    // MARK: - Coins
    
    static func id(_ id: String) -> [String: String] {
        ["id": id]
    }
    
    static func getCoinsMarkets(currency: String,
                                page: Int,
                                pageSize: Int) -> [String: Any] {
        [
            "vs_currency": currency,
            "page": page,
            "per_page": pageSize
        ]
    }
    
    static func getCoinMarketChart(currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval) -> [String: Any] {
        [
            "vs_currency": currency,
            "from": startTimeInterval,
            "to": endTimeInterval
        ]
    }
}
