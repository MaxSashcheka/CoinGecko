//
//  WalletsAPIDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public protocol WalletsAPIDataManagerProtocol {
    func createWallet(name: String,
                      userId: UUID,
                      colorHex: String,
                      success: @escaping Closure.Wallet,
                      failure: @escaping Closure.APIError)
    
    func getWallets(userId: UUID,
                    success: @escaping Closure.WalletsArray,
                    failure: @escaping Closure.APIError)
    
    func deleteWallet(id: UUID,
                      success: @escaping Closure.Wallet,
                      failure: @escaping Closure.APIError)
    
    func getCoinsIdentifiers(walletId: UUID,
                             success: @escaping Closure.CoinIdentifiersArray,
                             failure: @escaping Closure.APIError)
    
    func createCoinIdentifier(walletId: UUID,
                              amount: Float,
                              identifier: String,
                              success: @escaping Closure.Void,
                              failure: @escaping Closure.APIError)
}
