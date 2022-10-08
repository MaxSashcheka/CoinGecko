//
//  GlobalData.swift
//  Core
//
//  Created by Maksim Sashcheka on 5.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias GlobalData = (Core.GlobalData) -> (Swift.Void)
}

public struct GlobalData {
    public let activeCryptocurrencies: Int
    public let upcomingIcos: Int
    public let ongoingIcos: Int
    public let endedIcos: Int
    public let markets: Int
    public let previousDayChangePercentage: Double
}

public extension GlobalData {
    init(globalDataResponse: GlobalDataResponse) {
        self.activeCryptocurrencies = globalDataResponse.data.activeCryptocurrencies
        self.upcomingIcos = globalDataResponse.data.upcomingIcos
        self.ongoingIcos = globalDataResponse.data.ongoingIcos
        self.endedIcos = globalDataResponse.data.endedIcos
        self.markets = globalDataResponse.data.markets
        self.previousDayChangePercentage = globalDataResponse.data.marketCapChangePercentage24H
    }
}
