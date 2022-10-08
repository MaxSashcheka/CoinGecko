//
//  GlobalDataResponse.swift
//  Core
//
//  Created by Maksim Sashcheka on 5.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias GlobalDataResponse = (Core.GlobalDataResponse) -> (Swift.Void)
}

public struct GlobalDataResponse: Decodable {
    public let data: SomeResponse
    
}
public struct SomeResponse: Decodable {
    public let activeCryptocurrencies: Int
    public let upcomingIcos: Int
    public let ongoingIcos: Int
    public let endedIcos: Int
    public let markets: Int
    public let totalMarketCap: [String: Double]
    public let totalVolume: [String: Double]
    public let marketCapChangePercentage24H: Double
    
    private enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h_usd"
    }
}
