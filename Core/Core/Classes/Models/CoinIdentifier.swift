//
//  CoinIdentifier.swift
//  Core
//
//  Created by Maksim Sashcheka on 27.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias CoinIdentifier = (Core.CoinIdentifier) -> Swift.Void
    typealias CoinIdentifiersArray = ([Core.CoinIdentifier]) -> Swift.Void
}

public struct CoinIdentifier {
    public let id: UUID
    public let walletId: UUID
    public let identifier: String
    public let amount: Float
}

public extension CoinIdentifier {
    init(coinIdentifierResponse: CoinIdentifierResponse) {
        self.id = UUID(uuidString: coinIdentifierResponse.id) ?? UUID()
        self.walletId = UUID(uuidString: coinIdentifierResponse.walletId) ?? UUID()
        self.identifier = coinIdentifierResponse.identifier
        self.amount = coinIdentifierResponse.amount
    }
}

extension CoinIdentifier: CacheContainerConformable {
    public var cacheItemIdentifer: UUID { id }
}
