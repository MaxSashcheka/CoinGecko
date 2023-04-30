//
//  WalletsCacheDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public final class WalletsCacheDataManager: WalletsCacheDataManagerProtocol {
    public var cachedWallets = CacheContainer<UUID, Wallet>()
    public var cachedCoinIdentifiers = CacheContainer<UUID, CoinIdentifier>()
    
    public init() { }
}
