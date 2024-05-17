//
//  ParametersProviders.swift
//  Core
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

// TODO: - Make multiple extensions
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
    
    static func createPost(id: String,
                           title: String,
                           content: String,
                           authorId: String,
                           imageURL: String) -> [String: String] {
        [
            "id": id,
            "title": title,
            "content": content,
            "authorId": authorId,
            "imageURL": imageURL
        ]
    }
    
    static func login(login: String, password: String) -> [String: String] {
        [
            "login": login,
            "password": password
        ]
    }
    
    static func createWallet(id: String,
                             userId: String,
                             name: String,
                             colorHex: String) -> [String: String] {
        [
            "id": id,
            "userId": userId,
            "name": name,
            "colorHex": colorHex
        ]
    }
    
    static func createCoinIdentifier(id: String,
                                     amount: Float,
                                     identifier: String,
                                     walletId: String) -> [String: String] {
        [
            "id": id,
            "amount": amount.description,
            "identifier": identifier,
            "walletId": walletId
        ]
    }
}
