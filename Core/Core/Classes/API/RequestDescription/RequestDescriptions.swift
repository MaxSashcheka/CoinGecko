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
    enum BasePath {
        static let coinGecko = "https://api.coingecko.com/api/v3"
        static let localhost = "https://d31b-46-53-246-242.eu.ngrok.io"
    }
    
    class Coins {
        private static let basePath = BasePath.coinGecko + "/coins"
        
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
        private static let basePath = BasePath.coinGecko + "/search"
        
        public static let search = RequestDescription(
            path: basePath,
            method: .get,
            isAuthRequired: false
        )
    }
    
    class Global {
        private static let basePath = BasePath.coinGecko + "/global"
        
        public static let getGlobalData = RequestDescription(
            path: basePath,
            method: .get,
            isAuthRequired: false
        )
    }
    
    class Users {
        private static let basePath = BasePath.localhost
        
        public static let getAllUsers = RequestDescription(
            path: basePath + "/users",
            method: .get,
            isAuthRequired: false
        )
        
        public static let getUserById = RequestDescription(
            path: basePath + "/users/{id}",
            method: .get,
            isAuthRequired: false
        )
        
        public static let createUser = RequestDescription(
            path: basePath + "/users",
            method: .post,
            isAuthRequired: false
        )
        
        public static let login = RequestDescription(
            path: basePath + "/login",
            method: .post,
            isAuthRequired: false
        )
    }
    
    class Posts {
        private static let basePath = BasePath.localhost + "/posts"
        
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
        
        public static let getPost = RequestDescription(
            path: basePath + "/{id}",
            method: .get,
            isAuthRequired: false
        )
    }
    
    class Wallets {
        private static let basePath = BasePath.localhost + "/wallets"
        
        public static let createWallet = RequestDescription(
            path: basePath,
            method: .post,
            isAuthRequired: false
        )
        
        public static let getWalletsByUserId = RequestDescription(
            path: basePath + "/{id}",
            method: .get,
            isAuthRequired: false
        )
        
        public static let deleteWalletById = RequestDescription(
            path: basePath + "/{id}",
            method: .delete,
            isAuthRequired: false
        )
    }
    
    class CoinsIdentifier {
        private static let basePath = BasePath.localhost + "/coins"
        
        public static let createCoin = RequestDescription(
            path: basePath,
            method: .post,
            isAuthRequired: false
        )
        
        public static let getCoinsByWalletId = RequestDescription(
            path: basePath + "/{id}",
            method: .get,
            isAuthRequired: false
        )
    }
}

