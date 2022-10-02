//
//  CoinsAPIDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Utils

public class CoinsAPIDataManager: CoinsAPIDataManagerProtocol {
    public init() { }
    
    public func getCoins(currency: String,
                         page: Int,
                         pageSize: Int) -> AnyPublisher<[Coin], APIError> {
        APIClient.Combine.getCoinsMarkets(currency: currency, page: page, pageSize: pageSize)
            .flatMap { response in
                Just(response)
                    .map { $0.map { Coin(coinResponse: $0) } }
            }
            .eraseToAnyPublisher()
    }
    
    public func getCoinMarketChart(id: String,
                                   currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval) -> AnyPublisher<CoinChartData, APIError> {
        APIClient.Combine.getCoinMarketChart(id: id,
                                             currency: currency,
                                             startTimeInterval: startTimeInterval,
                                             endTimeInterval: endTimeInterval)
            .flatMap { response in
                Just(response)
                    .map { CoinChartData(coinChartDataResponse: $0) }
            }
            .eraseToAnyPublisher()
    }
    
}
