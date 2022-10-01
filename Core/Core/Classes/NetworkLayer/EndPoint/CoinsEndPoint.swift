//
//  CoinsEndPoint.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public enum CoinsEnpoint {
    case markets(currency: String,
                 page: Int,
                 pageSize: Int)
    
    case coinMarketChart(id: String,
                         currency: String,
                         startTimeInterval: TimeInterval,
                         endTimeInterval: TimeInterval)
}

extension CoinsEnpoint: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .markets: return "/markets"
        case .coinMarketChart: return "/{id}/market_chart/range"
        }
    }
    
    var httpMethod: HTTPMethod { .get }
    
    var task: HTTPTask {
        switch self {
        case let .markets(currency, page, pageSize):
            let urlParameters: Parameters = [
                "vs_currency": currency,
                "page": page,
                "per_page": pageSize
            ]
            return .requestParameters(urlParameters: urlParameters)

        case let .coinMarketChart(id, currency, startTimeInterval, endTimeInterval):
            let pathParameters: [String : String] = ["id": id]
            let urlParameters: Parameters = [
                "vs_currency": currency,
                "from": startTimeInterval,
                "to": endTimeInterval
            ]
            return .requestParameters(urlParameters: urlParameters, pathParameters: pathParameters)
        }
    }
    
    var headers: HTTPHeaders? { nil }
}
