//
//  CoinsAPIDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Utils

public protocol CoinsAPIDataManagerProtocol {
    func getCoins(currency: String,
                  page: Int,
                  pageSize: Int,
                  success: @escaping Closure.CoinsArray,
                  failure: @escaping Closure.APIError)
    
    func getCoinDetails(id: String,
                        success: @escaping Closure.CoinDetails,
                        failure: @escaping Closure.APIError)
    
    func getCoinMarketChart(id: String,
                            currency: String,
                            startTimeInterval: TimeInterval,
                            endTimeInterval: TimeInterval,
                            success: @escaping Closure.CoinChartData,
                            failure: @escaping Closure.APIError)
    
    func search(query: String,
                success: @escaping Closure.SearchResult,
                failure: @escaping Closure.APIError)
    
    func getGlobalData(success: @escaping Closure.GlobalData,
                       failure: @escaping Closure.APIError)
}
