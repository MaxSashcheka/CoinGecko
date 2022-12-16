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

public struct CoinChartData: Decodable {
    public let prices: [Double]
}

public extension CoinChartData {
    init(coinChartDataResponse: CoinChartDataResponse) {
        self.prices = coinChartDataResponse.prices.map { $0[1] }
    }
}
