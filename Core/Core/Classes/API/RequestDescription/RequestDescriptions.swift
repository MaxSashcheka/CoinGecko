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
        private static let basePath = "https://a433-2a00-1760-8006-5b-b5af-6d99-187e-b4e8.eu.ngrok.io"
        
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
        private static let basePath = "https://a433-2a00-1760-8006-5b-b5af-6d99-187e-b4e8.eu.ngrok.io/posts"
        
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
}
//https://firebasestorage.googleapis.com:443/v0/b/imagestorage-a16f8.appspot.com/o/images%2FC3313956-7A9B-431C-B21C-EEBB527093BC.jpg?alt=media&token=b453f3d0-77a4-4885-a944-795a2af1d357

