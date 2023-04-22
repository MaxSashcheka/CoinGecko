//
//  CoinsService.swift
//  Core
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Utils

public class CoinsService: CoinsServiceProtocol {
    private let coinsAPIDataManager: CoinsAPIDataManagerProtocol
    private let coinsCacheDataManager: CoinsCacheDataManagerProtocol
    
    public init(coinsAPIDataManager: CoinsAPIDataManagerProtocol,
                coinsCacheDataManager: CoinsCacheDataManagerProtocol) {
        self.coinsAPIDataManager = coinsAPIDataManager
        self.coinsCacheDataManager = coinsCacheDataManager
    }
    
    // MARK: - API methods
    public func getCoins(fromCache: Bool = false,
                         currency: String, page: Int, pageSize: Int,
                         success: @escaping Closure.CoinsArray,
                         failure: @escaping Closure.GeneralError) {
        if fromCache {
            success(coinsCacheDataManager.cachedCoins)
            return
        }
        coinsAPIDataManager.getCoins(
            currency: currency,
            page: page,
            pageSize: pageSize,
            success: { [weak self] coins in
                self?.coinsCacheDataManager.addToCache(coins: coins)
                success(coins)
            }, failure: failure)
    }
    
    public func getCoinDetails(id: String,
                               success: @escaping Closure.CoinDetails,
                               failure: @escaping Closure.GeneralError) {
        coinsAPIDataManager.getCoinDetails(
            id: id,
            success: success,
            failure: failure
        )
    }
    
    public func getCoinMarketChart(id: String,
                                   currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval,
                                   success: @escaping Closure.CoinChartData,
                                   failure: @escaping Closure.GeneralError) {
        coinsAPIDataManager.getCoinMarketChart(
            id: id,
            currency: currency,
            startTimeInterval: startTimeInterval,
            endTimeInterval: endTimeInterval,
            success: success,
            failure: failure
        )
    }
    
    public func search(query: String,
                       success: @escaping Closure.SearchResult,
                       failure: @escaping Closure.GeneralError) {
        coinsAPIDataManager.search(
            query: query,
            success: success,
            failure: failure
        )
    }
    
    public func getGlobalData(success: @escaping Closure.GlobalData,
                              failure: @escaping Closure.GeneralError) {
        coinsAPIDataManager.getGlobalData(
            success: success,
            failure: failure
        )
    }
    
    // MARK: - Cache methods
    public func addToCache(coins: [Coin]) {
        coinsCacheDataManager.addToCache(coins: coins)
    }
    
    public func cachedCoin(withId id: String) -> Coin? {
        coinsCacheDataManager.cachedCoin(withId: id)
    }
}
