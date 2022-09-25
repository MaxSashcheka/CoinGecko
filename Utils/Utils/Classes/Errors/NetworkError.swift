//
//  NetworkError.swift
//  Utils
//
//  Created by Maksim Sashcheka on 19.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public enum NetworkRouterError: String, Error {
    case noInternetConnection = "Please check your internet connection"
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
    case unableToBuildRequest = "Error during building url request"
}

public typealias NetworkRouterErrorClosure = (NetworkRouterError) -> Void
