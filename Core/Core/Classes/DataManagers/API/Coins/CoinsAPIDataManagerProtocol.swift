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
                  completion: @escaping Completion<[Coin], APIError>)
    
    func getCoinDetails(id: String,
                        completion: @escaping Completion<CoinDetails, APIError>)
    
    func getCoinMarketChart(id: String,
                            currency: String,
                            startTimeInterval: TimeInterval,
                            endTimeInterval: TimeInterval,
                            completion: @escaping Completion<CoinChartData, APIError>)
    
    func search(query: String,
                completion: @escaping Completion<SearchResult, APIError>)
    
    func getGlobalData(completion: @escaping Completion<GlobalData, APIError>)
}
