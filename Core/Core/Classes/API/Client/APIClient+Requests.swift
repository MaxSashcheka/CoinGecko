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
                                failure: @escaping Closure.APIError) {
        let endpoint = RequestDescription
            .Coins
            .getCoinsMarkets
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
    
    static func getCoinMarketChart(id: String,
                                   currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval,
                                   success: @escaping (CoinChartDataResponse) -> Void,
                                   failure: @escaping Closure.APIError) {
        let endpoint = RequestDescription
            .Coins
            .getCoinMarketChart
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
}
