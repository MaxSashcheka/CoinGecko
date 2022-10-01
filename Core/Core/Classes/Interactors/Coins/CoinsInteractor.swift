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
                         success: @escaping ([Coin]) -> Void,
                         failure: @escaping NetworkRouterErrorClosure) {
        coinsAPIDataManager.getCoins(currency: currency, page: page, pageSize: pageSize,
                                     success: { success($0.map { .init(coinResponse: $0) })},
                                     failure: failure)
    }
    
    public func getCoinMarketChart(id: String, currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval,
                                   success: @escaping (CoinChartData) -> Void,
                                   failure: @escaping NetworkRouterErrorClosure) {
        coinsAPIDataManager.getCoinMarketChart(id: id, currency: currency,
                                               startTimeInterval: startTimeInterval,
                                               endTimeInterval: endTimeInterval,
                                               success: { success(.init(coinChartDataResponse: $0 )) },
                                               failure: failure)
    }
}
