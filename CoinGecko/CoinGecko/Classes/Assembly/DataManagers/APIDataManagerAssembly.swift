//
//  APIDataManagerAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class APIDataManagerAssembly: Assembly {
    static func makeCoinsAPIDataManager() -> CoinsAPIDataManagerProtocol {
        CoinsAPIDataManager()
    }
}
