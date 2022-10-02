//
//  RequestDescriptions.swift
//  Core
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Alamofire
import Foundation

public extension RequestDescription {
    class Coins {
        private static let basePath = "coins"
        
        public static let getCoinsMarkets = RequestDescription(
            path: basePath + "/markets",
            method: .get,
            isAuthRequired: false
        )
        
        public static let getCoinMarketChart = RequestDescription(
            path: basePath + "/{id}/market_chart/range",
            method: .get,
            isAuthRequired: false
        )
    }
}

