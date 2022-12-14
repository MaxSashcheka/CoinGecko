//
//  APIClient+Requests.swift
//  Core
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Alamofire
import Utils

public extension APIClient {
    static func getCoinsMarkets(currency: String,
                                page: Int,
                                pageSize: Int,
                                success: @escaping ([CoinResponse]) -> Void,
                                failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Coins.getCoinsMarkets
            .replacingQueryParameters(
                .getCoinsMarkets(
                    currency: currency,
                    page: page,
                    pageSize: pageSize
                )
            )
        
        let request = makeDataRequest(for: endpoint)
        
        execute(request: request, success: success, failure: failure)
    }
    
    static func getCoinDetails(id: String,
                               success: @escaping Closure.CoinDetailsResponse,
                               failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Coins.getCoinDetails
            .replacingInlineArguments(
                .id(id)
            )
        let request = makeDataRequest(for: endpoint)
        
        execute(request: request, success: success, failure: failure)
    }
    
    static func getCoinMarketChart(id: String,
                                   currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval,
                                   success: @escaping Closure.CoinChartDataResponse,
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
        
        let request = makeDataRequest(for: endpoint)
        
        execute(request: request, success: success, failure: failure)
    }
    
    static func search(query: String,
                       success: @escaping Closure.SearchResponse,
                       failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Search.search
            .replacingQueryParameters(
                .search(
                    query: query
                )
            )
        
        let request = makeDataRequest(for: endpoint)
        
        execute(request: request, success: success, failure: failure)
    }
    
    static func getGlobalData(success: @escaping Closure.GlobalDataResponse,
                              failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Global.getGlobalData
        let request = makeDataRequest(for: endpoint)
        
        execute(request: request, success: success, failure: failure)
    }
}
