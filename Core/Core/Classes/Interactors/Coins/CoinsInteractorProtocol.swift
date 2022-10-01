//
//  CoinsInteractorProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public protocol CoinsInteractorProtocol: Interactor {
    func getCoins(fromCache: Bool,
                  currency: String, page: Int, pageSize: Int,
                  success: @escaping ([Coin]) -> Void,
                  failure: @escaping NetworkRouterErrorClosure)
    
    func getCoinMarketChart(id: String, currency: String,
                            startTimeInterval: TimeInterval,
                            endTimeInterval: TimeInterval,
                            success: @escaping (CoinChartData) -> Void,
                            failure: @escaping NetworkRouterErrorClosure)
}
