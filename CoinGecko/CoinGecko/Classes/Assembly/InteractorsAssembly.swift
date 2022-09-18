//
//  InteractorsAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class InteractorsAssembly: Assembly {
    static func makeCoinsInteractor(resolver: Resolver) -> CoinsInteractorProtocol {
        CoinsInteractor(
            coinsAPIDataManager: CoinsAPIDataManager()
        )
    }
}
