//
//  CoinsEndPoint.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public enum CoinsEnpoint {
    case markets(currency: String, page: Int, pageSize: Int)
}

extension CoinsEnpoint: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .markets: return "/markets"
        }
    }
    
    var httpMethod: HTTPMethod { .get }
    
    var task: HTTPTask {
        switch self {
        case .markets(let currency, let page, let pageSize):
            let urlParameters: Parameters = [
                "vs_currency": currency,
                "page": page,
                "per_page": pageSize
            ]
            return .requestParameters(urlParameters: urlParameters)
        }
    }
    
    var headers: HTTPHeaders? { nil }
}
