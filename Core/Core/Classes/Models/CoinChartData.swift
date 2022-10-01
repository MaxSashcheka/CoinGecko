//
//  CoinChartData.swift
//  Core
//
//  Created by Maksim Sashcheka on 25.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public struct CoinChartData: Decodable {
    public let prices: [Float]
}

public extension CoinChartData {
    init(coinChartDataResponse: CoinChartDataResponse) {
        self.prices = coinChartDataResponse.prices.map { $0[1] }
    }
}
