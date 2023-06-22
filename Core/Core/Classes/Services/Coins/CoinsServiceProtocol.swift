//
//  CoinsServiceProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public protocol CoinsServiceProtocol {
    func getStoredCoin(id: String,
                       completion: @escaping Completion<Coin, ServiceError>)
    
    func getCoins(fromCache: Bool,
                  currency: String, page: Int, pageSize: Int,
                  completion: @escaping Completion<[Coin], ServiceError>)
    
    func getCoinDetails(id: String,
                        completion: @escaping Completion<CoinDetails, ServiceError>)
    
    func getCoinMarketChart(id: String, currency: String,
                            startTimeInterval: TimeInterval,
                            endTimeInterval: TimeInterval,
                            completion: @escaping Completion<CoinChartData, ServiceError>)
    
    func search(query: String,
                completion: @escaping Completion<SearchResult, ServiceError>)
    
    func getGlobalData(completion: @escaping Completion<GlobalData, ServiceError>)
}
