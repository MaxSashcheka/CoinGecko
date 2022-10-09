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
                  pageSize: Int) -> AnyPublisher<[Coin], APIError>
    
    func getCoinDetails(id: String) -> AnyPublisher<CoinDetails, APIError>
    
    func getCoinMarketChart(id: String,
                            currency: String,
                            startTimeInterval: TimeInterval,
                            endTimeInterval: TimeInterval) -> AnyPublisher<CoinChartData, APIError>
    
    func search(query: String) -> AnyPublisher<SearchResult, APIError>
    
    func getGlobalData() -> AnyPublisher<GlobalData, APIError>
}
