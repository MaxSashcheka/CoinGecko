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
                             failure: @escaping Closure.GeneralError) {
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
            responseType: WalletResponse.self,
            success: { success(Wallet(walletResponse: $0)) },
            failure: failure
        )
    }
    
    public func getWallets(userId: UUID,
                           success: @escaping Closure.WalletsArray,
                           failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Wallets.getWalletsByUserId
            .replacingInlineArguments(
                .id(userId.uuidString)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            responseType: [WalletResponse].self,
            success: { success($0.map { Wallet(walletResponse: $0) }) },
            failure: failure
        )
    }
    
    public func deleteWallet(id: UUID,
                             success: @escaping Closure.Wallet,
                             failure: @escaping Closure.GeneralError) {
        let endpoint = RequestDescription.Wallets.deleteWalletById
            .replacingInlineArguments(
                .id(id.uuidString)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            responseType: WalletResponse.self,
            success: { success(Wallet(walletResponse: $0)) },
            failure: failure
        )
    }
}
