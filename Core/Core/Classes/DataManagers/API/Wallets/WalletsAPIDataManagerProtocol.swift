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
                      completion: @escaping Completion<Wallet, APIError>)
    
    func getWallets(userId: UUID,
                    completion: @escaping Completion<[Wallet], APIError>)
    
    func deleteWallet(id: UUID,
                      completion: @escaping Completion<Wallet, APIError>)
    
    func getCoinsIdentifiers(walletId: UUID,
                             completion: @escaping Completion<[CoinIdentifier], APIError>)
    
    func createCoinIdentifier(walletId: UUID,
                              amount: Float,
                              identifier: String,
                              completion: @escaping Completion<Void, APIError>)
}
