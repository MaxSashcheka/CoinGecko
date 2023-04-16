//
//  CoinsAPIDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Utils

public final class CoinsAPIDataManager: APIDataManager, CoinsAPIDataManagerProtocol {
    public func getCoins(currency: String,
                         page: Int,
                         pageSize: Int,
                         success: @escaping Closure.CoinsArray,
                         failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Coins.getCoinsMarkets
            .replacingQueryParameters(
                .getCoinsMarkets(
                    currency: currency,
                    page: page,
                    pageSize: pageSize
                )
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            responseType: [CoinResponse].self,
            success: { success($0.map { Coin(coinResponse: $0) }) },
            failure: failure
        )
    }
    
    public func getCoinDetails(id: String,
                               success: @escaping Closure.CoinDetails,
                               failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Coins.getCoinDetails
            .replacingInlineArguments(
                .id(id)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            responseType: CoinDetailsResponse.self,
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
        let endpoint = RequestDescription.Coins.getCoinMarketChart
            .replacingQueryParameters(
                .getCoinMarketChart(
                    currency: currency,
                    startTimeInterval: startTimeInterval,
                    endTimeInterval: endTimeInterval
                )
            )
            .replacingInlineArguments(
                .id(id)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            responseType: CoinChartDataResponse.self,
            success: { success(CoinChartData(coinChartDataResponse: $0)) },
            failure: failure
        )
    }
    
    public func search(query: String,
                       success: @escaping Closure.SearchResult,
                       failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Search.search
            .replacingQueryParameters(
                .search(
                    query: query
                )
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            responseType: SearchResponse.self,
            success: { success(SearchResult(searchResponse: $0)) },
            failure: failure
        )
    }
    
    public func getGlobalData(success: @escaping Closure.GlobalData,
                              failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Global.getGlobalData
        
        execute(
            request: makeDataRequest(for: endpoint),
            responseType: GlobalDataResponse.self,
            success: { success(GlobalData(globalDataResponse: $0)) },
            failure: failure
        )
    }
    
}
