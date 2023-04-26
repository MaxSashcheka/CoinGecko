//
//  WalletsCacheDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public protocol WalletsCacheDataManagerProtocol {
    var cachedWallets: CacheContainer<UUID, Wallet> { get set }
}
