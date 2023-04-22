//
//  ParametersProviders.swift
//  Core
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public extension ParametersProvider {
    static func id(_ id: String) -> [String: String] {
        ["id": id]
    }
    
    static func getCoinsMarkets(currency: String,
                                page: Int,
                                pageSize: Int) -> [String: Any] {
        [
            "vs_currency": currency,
            "page": page,
            "per_page": pageSize
        ]
    }
    
    static func getCoinMarketChart(currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval) -> [String: Any] {
        [
            "vs_currency": currency,
            "from": startTimeInterval,
            "to": endTimeInterval
        ]
    }
    
    static func search(query: String) -> [String: String] {
        ["query": query]
    }
    
    static func createUser(id: String,
                           name: String,
                           login: String,
                           password: String,
                           role: String,
                           imageURL: String,
                           email: String,
                           personalWebPageURL: String) -> [String: String] {
        [
            "id": id,
            "name": name,
            "login": login,
            "password": password,
            "role": role,
            "imageURL": imageURL,
            "email": email,
            "personalWebPageURL": personalWebPageURL
        ]
    }
}
