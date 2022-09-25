//
//  CoinsInteractorProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public protocol CoinsInteractorProtocol: Interactor {
    func getCoins(currency: String,
                  page: Int,
                  pageSize: Int,
                  success: @escaping ([Coin]) -> Void,
                  failure: @escaping NetworkRouterErrorClosure)
    
    func getCoinDetailInfo(id: String,
                           success: @escaping (CoinDetails) -> Void,
                           failure: @escaping NetworkRouterErrorClosure)
}
