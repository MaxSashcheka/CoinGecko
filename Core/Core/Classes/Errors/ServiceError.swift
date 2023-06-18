//
//  ServiceError.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.06.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

public enum ServiceErrorCode: Int, BaseErrorCode {
    case undefined
    
    // Wallets
    case createWallet
    case getWallets
    case deleteWallet
    case getCoinsIdentifiers
    case createCoinIdentifier
    
    // Users
    case fetchUsers
    case fetchUser
    case createUser
    
    // Auth
    case login
    
    // Posts
    case getPosts
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

public final class ServiceError: BaseError<ServiceErrorCode> {
    public static func wrap(_ closure: @escaping Closure.ServiceError,
                            code: ServiceErrorCode,
                            message: String? = nil,
                            method: String = #function) -> Closure.Error {
        { (error: Error) in
            closure(ServiceError(code: code, underlying: error, message: message, method: method))
        }
    }
}

public extension Closure {
    typealias ServiceError = (Core.ServiceError) -> Swift.Void
}
