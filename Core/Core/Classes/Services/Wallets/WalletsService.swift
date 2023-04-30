//
//  WalletsService.swift
//  Core
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public final class WalletsService: WalletsServiceProtocol {
    private let walletsCacheDataManager: WalletsCacheDataManagerProtocol
    private let usersCacheDataManager: UsersCacheDataManagerProtocol
    private let walletsAPIDataManager: WalletsAPIDataManagerProtocol
    
    public init(walletsCacheDataManager: WalletsCacheDataManagerProtocol,
                usersCacheDataManager: UsersCacheDataManagerProtocol,
                walletsAPIDataManager: WalletsAPIDataManagerProtocol) {
        self.walletsCacheDataManager = walletsCacheDataManager
        self.usersCacheDataManager = usersCacheDataManager
        self.walletsAPIDataManager = walletsAPIDataManager
    }
    
    public func createWallet(name: String,
                             colorHex: String,
                             success: @escaping Closure.Void,
                             failure: @escaping Closure.GeneralError) {
        guard let currentUser = usersCacheDataManager.currentUser else {
            failure(.defaultError)
            return
        }
        walletsAPIDataManager.createWallet(
            name: name,
            userId: currentUser.id,
            colorHex: colorHex,
            success: { [weak self] in
                self?.walletsCacheDataManager.cachedWallets.append($0)
                success()
            },
            failure: failure
        )
    }
    
    public func getWallet(id: UUID,
                          success: @escaping Closure.Wallet,
                          failure: @escaping Closure.GeneralError) {
        guard let wallet = walletsCacheDataManager.cachedWallets[id] else {
            failure(.defaultError)
            return
        }
        success(wallet)
    }
    
    public func getWallets(fromCache: Bool,
                           success: @escaping Closure.WalletsArray,
                           failure: @escaping Closure.GeneralError) {
        if fromCache {
            success(walletsCacheDataManager.cachedWallets.allItems)
        }
        guard let currentUser = usersCacheDataManager.currentUser else {
            failure(.defaultError)
            return
        }
        walletsAPIDataManager.getWallets(
            userId: currentUser.id,
            success: { [weak self] in
                self?.walletsCacheDataManager.cachedWallets.append(contentsOf: $0)
                success($0)
            },
            failure: failure
        )
    }
    
    public func deleteWallet(id: UUID,
                             success: @escaping Closure.Void,
                             failure: @escaping Closure.GeneralError) {
        walletsAPIDataManager.deleteWallet(
            id: id,
            success: { [weak self] in
                self?.walletsCacheDataManager.cachedWallets.removeItem(with: $0.id)
                success()
            },
            failure: failure
        )
    }
    
    public func getCoinsIdentifiers(walletId: UUID,
                                    success: @escaping Closure.CoinIdentifiersArray,
                                    failure: @escaping Closure.GeneralError) {
        walletsAPIDataManager.getCoinsIdentifiers(
            walletId: walletId,
            success: success,
            failure: failure
        )
    }
    
    public func createCoinIdentifier(walletId: UUID,
                                     amount: Float,
                                     identifier: String,
                                     success: @escaping Closure.Void,
                                     failure: @escaping Closure.GeneralError) {
        walletsAPIDataManager.createCoinIdentifier(
            walletId: walletId,
            amount: amount,
            identifier: identifier,
            success: success,
            failure: failure
        )
    }
    
    public func save(coinsIdentifier: [CoinIdentifier]) {
        walletsCacheDataManager.cachedCoinIdentifiers.append(contentsOf: coinsIdentifier)
    }
    
    public func coinAmount(for identifier: String) -> Float {
        guard let coinIdentifier = walletsCacheDataManager.cachedCoinIdentifiers.allItems.first(
            where: { $0.identifier == identifier }
        ) else { return .zero }
        return coinIdentifier.amount
    }
    
    public func clearCoinsIdentifiers() {
        walletsCacheDataManager.cachedCoinIdentifiers.clear()
    }
}
