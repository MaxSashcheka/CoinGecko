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
    
    public func getCoins(currency: String,
                         page: Int,
                         pageSize: Int,
                         success: @escaping ([Coin]) -> Void,
                         failure: @escaping NetworkRouterErrorClosure) {
        coinsAPIDataManager.getCoins(currency: currency,
                                     page: page,
                                     pageSize: pageSize,
                                     success: success,
                                     failure: failure)
    }
    
    public func getCoinDetailInfo(id: String,
                                  success: @escaping (CoinDetails) -> Void,
                                  failure: @escaping NetworkRouterErrorClosure) {
        coinsAPIDataManager.getCoinDetailInfo(id: id,
                                              success: success,
                                              failure: failure)
    }
}
