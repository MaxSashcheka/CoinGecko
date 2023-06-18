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
                             success: @escaping Closure.Wallet,
                             failure: @escaping Closure.APIError) {
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
            success: { success(Wallet(walletResponse: $0)) },
            failure: failure
        )
    }
    
    public func getWallets(userId: UUID,
                           success: @escaping Closure.WalletsArray,
                           failure: @escaping Closure.APIError) {
        let endpoint = RequestDescription.Wallets.getWalletsByUserId
            .replacingInlineArguments(
                .id(userId.uuidString)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .getWallets,
            responseType: [WalletResponse].self,
            success: { success($0.map { Wallet(walletResponse: $0) }) },
            failure: failure
        )
    }
    
    public func deleteWallet(id: UUID,
                             success: @escaping Closure.Wallet,
                             failure: @escaping Closure.APIError) {
        let endpoint = RequestDescription.Wallets.deleteWalletById
            .replacingInlineArguments(
                .id(id.uuidString)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .deleteWallet,
            responseType: WalletResponse.self,
            success: { success(Wallet(walletResponse: $0)) },
            failure: failure
        )
    }
    
    public func getCoinsIdentifiers(walletId: UUID,
                                    success: @escaping Closure.CoinIdentifiersArray,
                                    failure: @escaping Closure.APIError) {
        let endpoint = RequestDescription.CoinsIdentifier.getCoinsByWalletId
            .replacingInlineArguments(
                .id(walletId.uuidString)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .getCoinsIdentifiers,
            responseType: [CoinIdentifierResponse].self,
            success: { success($0.map { CoinIdentifier(coinIdentifierResponse: $0) }) },
            failure: failure
        )
    }
    
    public func createCoinIdentifier(walletId: UUID,
                                     amount: Float,
                                     identifier: String,
                                     success: @escaping Closure.Void,
                                     failure: @escaping Closure.APIError) {
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
            success: success,
            failure: failure
        )
    }
}
