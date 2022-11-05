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
                         pageSize: Int) -> AnyPublisher<[Coin], APIError> {
        APIClient.Combine.getCoinsMarkets(currency: currency, page: page, pageSize: pageSize)
            .flatMap { response in
                Just(response)
                    .map { $0.map { Coin(coinResponse: $0) } }
            }
            .eraseToAnyPublisher()
    }
    
    public func getCoinDetails(id: String) -> AnyPublisher<CoinDetails, APIError> {
        APIClient.Combine.getCoinDetails(id: id)
            .flatMap { response in
                Just(response)
                    .map { CoinDetails(coinDetailsResponse: $0) }
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
    
    public func search(query: String) -> AnyPublisher<SearchResult, APIError> {
        APIClient.Combine.search(query: query)
            .flatMap { response in
                Just(response)
                    .map { SearchResult(searchResponse: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    public func getGlobalData() -> AnyPublisher<GlobalData, APIError> {
        APIClient.Combine.getGlobalData()
            .flatMap { response in
                Just(response)
                    .map { GlobalData(globalDataResponse: $0) }
            }
            .eraseToAnyPublisher()
    }
    
}
