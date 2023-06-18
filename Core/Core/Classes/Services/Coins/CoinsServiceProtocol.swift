//
//  CoinsServiceProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public protocol CoinsServiceProtocol {
    func getStoredCoin(id: String,
                       success: @escaping Closure.Coin,
                       failure: @escaping Closure.ServiceError)
    
    func getCoins(fromCache: Bool,
                  currency: String, page: Int, pageSize: Int,
                  success: @escaping Closure.CoinsArray,
                  failure: @escaping Closure.ServiceError)
    
    func getCoinDetails(id: String,
                        success: @escaping Closure.CoinDetails,
                        failure: @escaping Closure.ServiceError)
    
    func getCoinMarketChart(id: String, currency: String,
                            startTimeInterval: TimeInterval,
                            endTimeInterval: TimeInterval,
                            success: @escaping Closure.CoinChartData,
                            failure: @escaping Closure.ServiceError)
    
    func search(query: String,
                success: @escaping Closure.SearchResult,
                failure: @escaping Closure.ServiceError)
    
    func getGlobalData(success: @escaping Closure.GlobalData,
                       failure: @escaping Closure.ServiceError)
}
