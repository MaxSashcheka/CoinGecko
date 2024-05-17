//
//  WalletsAPIDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public final class WalletsAPIDataManager: APIDataManager, WalletsAPIDataManagerProtocol {
    public func createWallet(name: String,
                             userId: UUID,
                             colorHex: String,
                             completion: @escaping Completion<Wallet, APIError>) {
        let endpoint = RequestDescription.Wallets.createWallet
            .replacingParameters(
                .createWallet(
                    id: UUID().uuidString,
                    userId: userId.uuidString,
                    name: name,
                    colorHex: colorHex
                )
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .createWallet,
            responseType: WalletResponse.self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(Wallet(walletResponse: response)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    public func getWallets(userId: UUID,
                           completion: @escaping Completion<[Wallet], APIError>) {
        let endpoint = RequestDescription.Wallets.getWalletsByUserId
            .replacingInlineArguments(
                .id(userId.uuidString)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .getWallets,
            responseType: [WalletResponse].self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(response.map { Wallet(walletResponse: $0) }))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    public func deleteWallet(id: UUID,
                             completion: @escaping Completion<Wallet, APIError>) {
        let endpoint = RequestDescription.Wallets.deleteWalletById
            .replacingInlineArguments(
                .id(id.uuidString)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .deleteWallet,
            responseType: WalletResponse.self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(Wallet(walletResponse: response)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    public func getCoinsIdentifiers(walletId: UUID,
                                    completion: @escaping Completion<[CoinIdentifier], APIError>) {
        let endpoint = RequestDescription.CoinsIdentifier.getCoinsByWalletId
            .replacingInlineArguments(
                .id(walletId.uuidString)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .getCoinsIdentifiers,
            responseType: [CoinIdentifierResponse].self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(
                        .success(
                            response.map {
                                CoinIdentifier(coinIdentifierResponse: $0)
                            }
                        )
                    )
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    public func createCoinIdentifier(walletId: UUID,
                                     amount: Float,
                                     identifier: String,
                                     completion: @escaping Completion<Void, APIError>) {
        let endpoint = RequestDescription.CoinsIdentifier.createCoin
            .replacingParameters(
                .createCoinIdentifier(
                    id: UUID().uuidString,
                    amount: amount,
                    identifier: identifier,
                    walletId: walletId.uuidString
                )
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .createCoinIdentifier,
            completion: completion
        )
    }
}
