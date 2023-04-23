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
        private static let basePath = "https://api.coingecko.com/api/v3/coins"
        
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
        private static let basePath = "https://api.coingecko.com/api/v3/search"
        
        public static let search = RequestDescription(
            path: basePath,
            method: .get,
            isAuthRequired: false
        )
    }
    
    class Global {
        private static let basePath = "https://api.coingecko.com/api/v3/global"
        
        public static let getGlobalData = RequestDescription(
            path: basePath,
            method: .get,
            isAuthRequired: false
        )
    }
    
    class Users {
        private static let basePath = "https://f6e2-2a00-1760-8006-5b-89a6-bbf3-67d9-ebfa.eu.ngrok.io/users"
        
        public static let createUser = RequestDescription(
            path: basePath,
            method: .post,
            isAuthRequired: false
        )
    }
    
    class Posts {
        private static let basePath = "https://f6e2-2a00-1760-8006-5b-89a6-bbf3-67d9-ebfa.eu.ngrok.io/posts"
        
        public static let createPost = RequestDescription(
            path: basePath,
            method: .post,
            isAuthRequired: false
        )
        
        public static let getAllPosts = RequestDescription(
            path: basePath,
            method: .get,
            isAuthRequired: false
        )
    }
}

