//
//  CoinChartData.swift
//  Core
//
//  Created by Maksim Sashcheka on 25.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias CoinChartData = (Core.CoinChartData) -> Swift.Void
}

public struct CoinChartData {
    public let pricesWithData: [PriceMetadata]
}

public struct PriceMetadata {
    public let price: Double
    public let date: Date
}

public extension CoinChartData {
    init(coinChartDataResponse: CoinChartDataResponse) {
        self.pricesWithData = coinChartDataResponse.prices.map {
            PriceMetadata(
                price: $0[1],
                date: Date(
                    timeIntervalSince1970: Double(String($0[0]).dropLast(5).description) ?? .zero
                )
            )
        }
    }
}
