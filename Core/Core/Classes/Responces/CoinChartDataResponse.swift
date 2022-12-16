//
//  CoinChartDataResponse.swift
//  Core
//
//  Created by Maksim Sashcheka on 30.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias CoinChartDataResponse = (Core.CoinChartDataResponse) -> (Swift.Void)
}

public struct CoinChartDataResponse: Decodable {
    public let prices: [[Double]]
}
