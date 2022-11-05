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
    private let coinsCacheDataManager: CoinsCacheDataManagerProtocol
    
    public init(coinsAPIDataManager: CoinsAPIDataManagerProtocol,
                coinsCacheDataManager: CoinsCacheDataManagerProtocol) {
        self.coinsAPIDataManager = coinsAPIDataManager
        self.coinsCacheDataManager = coinsCacheDataManager
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
    
    public func getStoredCoins(success: @escaping Closure.CoinsArray,
                               failure: @escaping Closure.Error) {
        coinsCacheDataManager.getStoredCoins()
            .strongSink(receiveValue: success, receiveError: failure)
    }
    
    public func createOrUpdate(coins: [Coin],
                               success: @escaping Closure.Void,
                               failure: @escaping Closure.Error) {
        coinsCacheDataManager.createOrUpdate(coins: coins)
            .strongSink(receiveValue: success, receiveError: failure)
    }
    
    public func createOrUpdate(coin: Coin,
                               success: @escaping Closure.Void,
                               failure: @escaping Closure.Error) {
        createOrUpdate(coins: [coin], success: success, failure: failure)
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
