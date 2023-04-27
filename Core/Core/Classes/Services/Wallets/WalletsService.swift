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
}
