//
//  WalletsServiceProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public protocol WalletsServiceProtocol {
    func createWallet(name: String,
                      colorHex: String,
                      success: @escaping Closure.Void,
                      failure: @escaping Closure.ServiceError)
    
    func getWallets(fromCache: Bool,
                    success: @escaping Closure.WalletsArray,
                    failure: @escaping Closure.ServiceError)
    
    func deleteWallet(id: UUID,
                      success: @escaping Closure.Void,
                      failure: @escaping Closure.ServiceError)
    
    func getCoinsIdentifiers(walletId: UUID,
                             success: @escaping Closure.CoinIdentifiersArray,
                             failure: @escaping Closure.ServiceError)
    
    func createCoinIdentifier(walletId: UUID,
                              amount: Float,
                              identifier: String,
                              success: @escaping Closure.Void,
                              failure: @escaping Closure.ServiceError)
    
    func getWallet(id: UUID,
                   success: @escaping Closure.Wallet,
                   failure: @escaping Closure.ServiceError)
    
    func save(coinsIdentifier: [CoinIdentifier])
    
    func coinAmount(for identifier: String) -> Float
    
    func clearCoinsIdentifiers()
}
