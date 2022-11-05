//
//  CoinsInteractorProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public protocol CoinsInteractorProtocol: Interactor {
    // MARK: - API Methods
    func getCoins(fromCache: Bool,
                  currency: String, page: Int, pageSize: Int,
                  success: @escaping Closure.CoinsArray,
                  failure: @escaping Closure.APIError)
    
    func getCoinDetails(id: String,
                        success: @escaping Closure.CoinDetails,
                        failure: @escaping Closure.APIError)
    
    func getCoinMarketChart(id: String, currency: String,
                            startTimeInterval: TimeInterval,
                            endTimeInterval: TimeInterval,
                            success: @escaping Closure.CoinChartData,
                            failure: @escaping Closure.APIError)
    
    // MARK: - Cache Methods
    func getStoredCoins(success: @escaping Closure.CoinsArray,
                        failure: @escaping Closure.Error)
    
    func createOrUpdate(coins: [Coin],
                        success: @escaping Closure.Void,
                        failure: @escaping Closure.Error)
    
    func createOrUpdate(coin: Coin,
                        success: @escaping Closure.Void,
                        failure: @escaping Closure.Error)
    
    // TODO: - Implement search interactor
    func search(query: String,
                success: @escaping Closure.SearchResult,
                failure: @escaping Closure.APIError)
    
    // TODO: - Implement global data interactor
    func getGlobalData(success: @escaping Closure.GlobalData,
                       failure: @escaping Closure.APIError)
}
