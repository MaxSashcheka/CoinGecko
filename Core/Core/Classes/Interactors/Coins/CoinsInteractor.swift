//
//  CoinsInteractor.swift
//  Core
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public class CoinsInteractor: CoinsInteractorProtocol {
    private let coinsAPIDataManager: CoinsAPIDataManagerProtocol
    
    public init(coinsAPIDataManager: CoinsAPIDataManagerProtocol) {
        self.coinsAPIDataManager = coinsAPIDataManager
    }
    
    public func getCoins(fromCache: Bool = true,
                         currency: String, page: Int, pageSize: Int,
                         success: @escaping Closure.CoinsArray,
                         failure: @escaping Closure.APIError) {
        coinsAPIDataManager.getCoins(currency: currency, page: page, pageSize: pageSize)
            .strongSink(receiveValue: success, receiveError: failure)
        // TODO: - Replace receiveValue block with closure and implement saving coins to cache data manager
    }
    
    public func getCoinDetails(id: String,
                               success: @escaping Closure.CoinDetails,
                               failure: @escaping Closure.APIError) {
        coinsAPIDataManager.getCoinDetails(id: id)
            .strongSink(receiveValue: success, receiveError: failure)
    }
    
    public func getCoinMarketChart(id: String, currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval,
                                   success: @escaping Closure.CoinChartData,
                                   failure: @escaping Closure.APIError) {
        coinsAPIDataManager.getCoinMarketChart(id: id,
                                               currency: currency,
                                               startTimeInterval: startTimeInterval,
                                               endTimeInterval: endTimeInterval)
            .strongSink(receiveValue: success, receiveError: failure)
    }
    
    public func search(query: String,
                       success: @escaping Closure.SearchResult,
                       failure: @escaping Closure.APIError) {
        coinsAPIDataManager.search(query: query)
            .strongSink(receiveValue: success, receiveError: failure)
    }
    
    public func getGlobalData(success: @escaping Closure.GlobalData,
                              failure: @escaping Closure.APIError) {
        coinsAPIDataManager.getGlobalData()
            .strongSink(receiveValue: success, receiveError: failure)
    }
}
