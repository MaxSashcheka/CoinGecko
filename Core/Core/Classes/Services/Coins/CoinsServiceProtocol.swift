//
//  CoinsServiceProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public protocol CoinsServiceProtocol {
    // MARK: - API Methods
    func getCoins(fromCache: Bool,
                  currency: String, page: Int, pageSize: Int,
                  success: @escaping Closure.CoinsArray,
                  failure: @escaping Closure.GeneralError)
    
    func getCoinDetails(id: String,
                        success: @escaping Closure.CoinDetails,
                        failure: @escaping Closure.GeneralError)
    
    func getCoinMarketChart(id: String, currency: String,
                            startTimeInterval: TimeInterval,
                            endTimeInterval: TimeInterval,
                            success: @escaping Closure.CoinChartData,
                            failure: @escaping Closure.GeneralError)
    
    // MARK: - Cache Methods
    func addToCache(coins: [Coin])
    
    func cachedCoin(withId id: String) -> Coin?
    
    // TODO: - Implement search api data manager
    func search(query: String,
                success: @escaping Closure.SearchResult,
                failure: @escaping Closure.GeneralError)
    
    // TODO: - Implement global data api data manager
    func getGlobalData(success: @escaping Closure.GlobalData,
                       failure: @escaping Closure.GeneralError)
}
