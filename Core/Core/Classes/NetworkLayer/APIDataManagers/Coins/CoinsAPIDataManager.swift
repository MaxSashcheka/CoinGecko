//
//  CoinsAPIDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public class CoinsAPIDataManager: CoinsAPIDataManagerProtocol {
    private let router = NetworkRouter<CoinsEnpoint>()
    
    public init() { }
    
    public func getCoins(currency: String, page: Int, pageSize: Int,
                         success: @escaping ([CoinResponse]) -> Void,
                         failure: @escaping NetworkRouterErrorClosure) {
        router.request(
            .markets(
                currency: currency,
                page: page,
                pageSize: pageSize
            ),
            success: success,
            failure: failure
        )
    }
    
    public func getCoinMarketChart(id: String, currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval,
                                   success: @escaping (CoinChartDataResponse) -> Void,
                                   failure: @escaping NetworkRouterErrorClosure) {
        router.request(
            .coinMarketChart(
                id: id,
                currency: currency,
                startTimeInterval: startTimeInterval,
                endTimeInterval: endTimeInterval
            ),
            success: success,
            failure: failure
        )
    }
    
}
