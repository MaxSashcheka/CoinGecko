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
                      completion: @escaping Completion<Void, ServiceError>)
    
    func getWallets(fromCache: Bool,
                    completion: @escaping Completion<[Wallet], ServiceError>)
    
    func deleteWallet(id: UUID,
                      completion: @escaping Completion<Void, ServiceError>)
    
    func getCoinsIdentifiers(walletId: UUID,
                             completion: @escaping Completion<[CoinIdentifier], ServiceError>)
    
    func createCoinIdentifier(walletId: UUID,
                              amount: Float,
                              identifier: String,
                              completion: @escaping Completion<Void, ServiceError>)
    
    func getWallet(id: UUID,
                   completion: @escaping Completion<Wallet, ServiceError>)
    
    func save(coinsIdentifier: [CoinIdentifier])
    
    func coinAmount(for identifier: String) -> Float
    
    func clearCoinsIdentifiers()
}
