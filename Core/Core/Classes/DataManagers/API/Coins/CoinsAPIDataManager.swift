//
//  CoinsAPIDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Utils

public final class CoinsAPIDataManager: CoinsAPIDataManagerProtocol {
    public init() { }
    
    public func getCoins(currency: String,
                         page: Int,
                         pageSize: Int,
                         success: @escaping Closure.CoinsArray,
                         failure: @escaping Closure.GeneralError) {
        APIClient.getCoinsMarkets(
            currency: currency,
            page: page,
            pageSize: pageSize,
            success: { coinsResponces in
                success(coinsResponces.map { Coin(coinResponse: $0) })
        }, failure: failure)
    }
    
    public func getCoinDetails(id: String,
                               success: @escaping Closure.CoinDetails,
                               failure: @escaping Closure.GeneralError) {
        APIClient.getCoinDetails(
            id: id,
            success: { success(CoinDetails(coinDetailsResponse: $0)) },
            failure: failure
        )
    
    }
    
    public func getCoinMarketChart(id: String,
                                   currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval,
                                   success: @escaping Closure.CoinChartData,
                                   failure: @escaping Closure.GeneralError) {
        APIClient.getCoinMarketChart(
            id: id,
            currency: currency,
            startTimeInterval: startTimeInterval,
            endTimeInterval: endTimeInterval,
            success: { success(CoinChartData(coinChartDataResponse: $0)) },
            failure: failure
        )
    }
    
    public func search(query: String,
                       success: @escaping Closure.SearchResult,
                       failure: @escaping Closure.GeneralError) {
        APIClient.search(
            query: query,
            success: { success(SearchResult(searchResponse: $0)) },
            failure: failure
        )
    }
    
    public func getGlobalData(success: @escaping Closure.GlobalData,
                              failure: @escaping Closure.GeneralError) {
        APIClient.getGlobalData(
            success: { success(GlobalData(globalDataResponse: $0)) },
            failure: failure
        )
    }
    
}
