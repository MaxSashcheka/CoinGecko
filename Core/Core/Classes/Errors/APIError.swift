//
//  APIError.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.06.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public enum APIErrorCode: Int, BaseErrorCode {
    case undefined
    
    // Wallets
    case createWallet
    case getWallets
    case deleteWallet
    case getCoinsIdentifiers
    case createCoinIdentifier
    
    // Users
    case fetchAllUsers
    case fetchUser
    case createUser
    
    // Auth
    case login
    
    // Posts
    case getAllPosts
    case getPost
    case createPost
    
    // Coins
    case getStoredCoin
    case getCoins
    case getCoinDetails
    case getCoinMarketChart
    case search
    case getGlobalData
}

public final class APIError: BaseError<APIErrorCode> {
    public override var domainCode: String { "API" }
}

public extension Closure {
    typealias APIError = (Core.APIError) -> Swift.Void
}
