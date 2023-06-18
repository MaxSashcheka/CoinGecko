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
                             failure: @escaping Closure.ServiceError) {
        guard let currentUser = usersCacheDataManager.currentUser else {
            let appError = AppError(code: .unexpected, message: "Cached current user not found")
            failure(ServiceError(code: .createWallet, underlying: appError))
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
            failure: ServiceError.wrap(failure, code: .createWallet)
        )
    }
    
    public func getWallet(id: UUID,
                          success: @escaping Closure.Wallet,
                          failure: @escaping Closure.ServiceError) {
        guard let wallet = walletsCacheDataManager.cachedWallets[id] else {
            let appError = AppError(code: .unexpected, message: "Cached wallet not found")
            failure(ServiceError(code: .getStoredCoin, underlying: appError))
            return
        }
        success(wallet)
    }
    
    public func getWallets(fromCache: Bool,
                           success: @escaping Closure.WalletsArray,
                           failure: @escaping Closure.ServiceError) {
        if fromCache {
            success(walletsCacheDataManager.cachedWallets.allItems)
        }
        guard let currentUser = usersCacheDataManager.currentUser else {
            let appError = AppError(code: .unexpected, message: "Cached current user not found")
            failure(ServiceError(code: .createWallet, underlying: appError))
            return
        }
        walletsAPIDataManager.getWallets(
            userId: currentUser.id,
            success: { [weak self] in
                self?.walletsCacheDataManager.cachedWallets.append(contentsOf: $0)
                success($0)
            },
            failure: ServiceError.wrap(failure, code: .getWallets)
        )
    }
    
    public func deleteWallet(id: UUID,
                             success: @escaping Closure.Void,
                             failure: @escaping Closure.ServiceError) {
        walletsAPIDataManager.deleteWallet(
            id: id,
            success: { [weak self] in
                self?.walletsCacheDataManager.cachedWallets.removeItem(with: $0.id)
                success()
            },
            failure: ServiceError.wrap(failure, code: .deleteWallet)
        )
    }
    
    public func getCoinsIdentifiers(walletId: UUID,
                                    success: @escaping Closure.CoinIdentifiersArray,
                                    failure: @escaping Closure.ServiceError) {
        walletsAPIDataManager.getCoinsIdentifiers(
            walletId: walletId,
            success: success,
            failure: ServiceError.wrap(failure, code: .getCoinsIdentifiers)
        )
    }
    
    public func createCoinIdentifier(walletId: UUID,
                                     amount: Float,
                                     identifier: String,
                                     success: @escaping Closure.Void,
                                     failure: @escaping Closure.ServiceError) {
        walletsAPIDataManager.createCoinIdentifier(
            walletId: walletId,
            amount: amount,
            identifier: identifier,
            success: success,
            failure: ServiceError.wrap(failure, code: .createCoinIdentifier)
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
