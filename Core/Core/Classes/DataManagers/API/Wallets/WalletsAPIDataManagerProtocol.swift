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
                      failure: @escaping Closure.GeneralError)
    
    func getWallets(userId: UUID,
                    success: @escaping Closure.WalletsArray,
                    failure: @escaping Closure.GeneralError)
    
    func deleteWallet(id: UUID,
                      success: @escaping Closure.Wallet,
                      failure: @escaping Closure.GeneralError)
    
    func getCoinsIdentifiers(walletId: UUID,
                             success: @escaping ([String]) -> Void,
                             failure: @escaping Closure.GeneralError)
    
    func createCoinIdentifier(walletId: UUID,
                              identifier: String,
                              success: @escaping Closure.Void,
                              failure: @escaping Closure.GeneralError)
}
