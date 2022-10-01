//
//  CoinsAPIDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public protocol CoinsAPIDataManagerProtocol {
    func getCoins(currency: String,
                  page: Int,
                  pageSize: Int,
                  success: @escaping ([CoinResponse]) -> Void,
                  failure: @escaping NetworkRouterErrorClosure)
    
    func getCoinMarketChart(id: String, currency: String,
                            startTimeInterval: TimeInterval,
                            endTimeInterval: TimeInterval,
                            success: @escaping (CoinChartDataResponse) -> Void,
                            failure: @escaping NetworkRouterErrorClosure)
}
