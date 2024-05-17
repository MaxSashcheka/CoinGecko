//
//  Wallet.swift
//  Core
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias Wallet = (Core.Wallet) -> Swift.Void
    typealias WalletsArray = ([Core.Wallet]) -> Swift.Void
}

public struct Wallet {
    public let id: UUID
    public let userId: UUID
    public let name: String
    public let colorHex: String
    public let coinsCount: Int
}

public extension Wallet {
    init(walletResponse: WalletResponse) {
        self.id = UUID(uuidString: walletResponse.id) ?? UUID()
        self.userId = UUID(uuidString: walletResponse.userId) ?? UUID()
        self.name = walletResponse.name
        self.colorHex = walletResponse.colorHex
        self.coinsCount = walletResponse.coinsCount
    }
}

// MARK: Wallet+CacheContainerConformable
extension Wallet: CacheContainerConformable {
    public var cacheItemIdentifer: UUID { id }
}
