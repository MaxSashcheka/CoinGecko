//
//  CoinsInteractorProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public protocol CoinsInteractorProtocol: Interactor {
    func getCoins(fromCache: Bool,
                  currency: String, page: Int, pageSize: Int,
                  success: @escaping Closure.CoinsArray,
                  failure: @escaping Closure.APIError)
    
    func getCoinMarketChart(id: String, currency: String,
                            startTimeInterval: TimeInterval,
                            endTimeInterval: TimeInterval,
                            success: @escaping Closure.CoinChartData,
                            failure: @escaping Closure.APIError)
}
