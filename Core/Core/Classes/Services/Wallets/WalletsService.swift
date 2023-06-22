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
                             completion: @escaping Completion<Void, ServiceError>) {
        guard let currentUser = usersCacheDataManager.currentUser else {
            let appError = AppError(code: .unexpected, message: "Cached current user not found")
            completion(.failure(ServiceError(code: .createWallet, underlying: appError)))
            return
        }
        walletsAPIDataManager.createWallet(
            name: name,
            userId: currentUser.id,
            colorHex: colorHex,
            completion: { [weak self] result in
                switch result {
                case .success(let wallets):
                    self?.walletsCacheDataManager.cachedWallets.append(wallets)
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .createWallet, underlying: error)))
                }
            }
        )
    }
    
    public func getWallet(id: UUID,
                          completion: @escaping Completion<Wallet, ServiceError>) {
        guard let wallet = walletsCacheDataManager.cachedWallets[id] else {
            let appError = AppError(code: .unexpected, message: "Cached wallet not found")
            completion(.failure(ServiceError(code: .getStoredCoin, underlying: appError)))
            return
        }
        completion(.success(wallet))
    }
    
    public func getWallets(fromCache: Bool,
                           completion: @escaping Completion<[Wallet], ServiceError>) {
        if fromCache {
            completion(.success(walletsCacheDataManager.cachedWallets.allItems))
        }
        guard let currentUser = usersCacheDataManager.currentUser else {
            let appError = AppError(code: .unexpected, message: "Cached current user not found")
            completion(.failure(ServiceError(code: .createWallet, underlying: appError)))
            return
        }
        walletsAPIDataManager.getWallets(
            userId: currentUser.id,
            completion: { [weak self] result in
                switch result {
                case .success(let wallets):
                    self?.walletsCacheDataManager.cachedWallets.append(contentsOf: wallets)
                    completion(.success(wallets))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .getWallets, underlying: error)))
                }
            }
        )
    }
    
    public func deleteWallet(id: UUID,
                             completion: @escaping Completion<Void, ServiceError>) {
        walletsAPIDataManager.deleteWallet(
            id: id,
            completion: { [weak self] result in
                switch result {
                case .success(let wallet):
                    self?.walletsCacheDataManager.cachedWallets.removeItem(with: wallet.id)
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .deleteWallet, underlying: error)))
                }
            }
        )
    }
    
    public func getCoinsIdentifiers(walletId: UUID,
                                    completion: @escaping Completion<[CoinIdentifier], ServiceError>) {
        walletsAPIDataManager.getCoinsIdentifiers(
            walletId: walletId,
            completion: { result in
                switch result {
                case .success(let coinIdentifiers):
                    completion(.success(coinIdentifiers))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .getCoinsIdentifiers, underlying: error)))
                }
            }
        )
    }
    
    public func createCoinIdentifier(walletId: UUID,
                                     amount: Float,
                                     identifier: String,
                                     completion: @escaping Completion<Void, ServiceError>) {
        walletsAPIDataManager.createCoinIdentifier(
            walletId: walletId,
            amount: amount,
            identifier: identifier,
            completion: { result in
                switch result {
                case .success(_):
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .createCoinIdentifier, underlying: error)))
                }
            }
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
