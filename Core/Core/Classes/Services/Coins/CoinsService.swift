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
    
    public func getStoredCoin(id: String,
                              success: @escaping Closure.Coin,
                              failure: @escaping Closure.ServiceError) {
        guard let coin = coinsCacheDataManager.cachedCoins[id] else {
            let appError = AppError(code: .unexpected, message: "Cached coin not found")
            failure(ServiceError(code: .getStoredCoin, underlying: appError))
            return
        }
        success(coin)
    }
    
    // MARK: - API methods
    public func getCoins(fromCache: Bool = false,
                         currency: String, page: Int, pageSize: Int,
                         success: @escaping Closure.CoinsArray,
                         failure: @escaping Closure.ServiceError) {
        if fromCache {
            success(coinsCacheDataManager.cachedCoins.allItems)
            return
        }
        coinsAPIDataManager.getCoins(
            currency: currency,
            page: page,
            pageSize: pageSize,
            success: { [weak self] coins in
                self?.coinsCacheDataManager.cachedCoins.append(contentsOf: coins)
                success(coins)
            },
            failure: ServiceError.wrap(failure, code: .getCoins)
        )
    }
    
    public func getCoinDetails(id: String,
                               success: @escaping Closure.CoinDetails,
                               failure: @escaping Closure.ServiceError) {
        coinsAPIDataManager.getCoinDetails(
            id: id,
            success: success,
            failure: ServiceError.wrap(failure, code: .getCoinDetails)
        )
    }
    
    public func getCoinMarketChart(id: String,
                                   currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval,
                                   success: @escaping Closure.CoinChartData,
                                   failure: @escaping Closure.ServiceError) {
        coinsAPIDataManager.getCoinMarketChart(
            id: id,
            currency: currency,
            startTimeInterval: startTimeInterval,
            endTimeInterval: endTimeInterval,
            success: success,
            failure: ServiceError.wrap(failure, code: .getCoinMarketChart)
        )
    }
    
    public func search(query: String,
                       success: @escaping Closure.SearchResult,
                       failure: @escaping Closure.ServiceError) {
        coinsAPIDataManager.search(
            query: query,
            success: success,
            failure: ServiceError.wrap(failure, code: .search)
        )
    }
    
    public func getGlobalData(success: @escaping Closure.GlobalData,
                              failure: @escaping Closure.ServiceError) {
        coinsAPIDataManager.getGlobalData(
            success: success,
            failure: ServiceError.wrap(failure, code: .getGlobalData)
        )
    }
}
