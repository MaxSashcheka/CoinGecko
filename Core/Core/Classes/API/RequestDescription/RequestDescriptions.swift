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
        
        public static let getCoinDetails = RequestDescription(
            path: basePath + "/{id}",
            method: .get,
            isAuthRequired: false
        )
        
        public static let getCoinMarketChart = RequestDescription(
            path: basePath + "/{id}/market_chart/range",
            method: .get,
            isAuthRequired: false
        )
    }
    
    class Search {
        private static let basePath = "/search"
        
        public static let search = RequestDescription(
            path: basePath,
            method: .get,
            isAuthRequired: false
        )
    }
    
    class Global {
        private static let basePath = "/global"
        
        public static let getGlobalData = RequestDescription(
            path: basePath,
            method: .get,
            isAuthRequired: false
        )
    }
}

